require_relative './errors.rb'
require_relative "./rally-tools.rb"
require_relative "./serializable.rb"
require_relative "./provider_cache.rb"

require "json"

class Preset < Serializable
  extend DownloadableCache

  attr_accessor :name, :code
  attr_reader :type, :id, :rule_matches
  @@has_attribs = false

  class << self
    attr_accessor :code_match

    # this matches rules like "OR132 Blah blah", but is not reliable enough to
    # use. Instead, try using `parse_code_for_strings` and passing all known
    # presets that exist
    #Preset.code_match = /(([A-Z]+ )?[A-Z]{1,3}\d{2,5}\w{0,3}?\s(\- )?[\w .\d-]+)/
  end

  #This creates a preset class and does some initialization
  #  :local, <path>
  #  :silo, <attributes>, <code>, remote: remoteSilo
  def initialize type, data, code='', remote: nil
    @type = type
    if @type == :local
      @path = data
      @code = RallyTools::open_file(@path)
      @name = parse_preset_for_name
      begin
        @metadata = JSON.parse IO.read get_metadata_path
      rescue Errno::ENOENT
        @metadata = {}
        puts "Metadata file not found. No action"
        #fill out some basic info for evals
        if @path.end_with? ".py"
          @metadata["providerName"] = "SdviEvaluate"
          @metadata["providerSettings"] = {
            "OutputStorageName" => nil,
            "PresetName": @name,
            "ProxyTypeName": nil,
          }
        end
      end
    elsif @type == :silo
      @remote = remote
      @path = nil
      @id = data["id"]
      code = nil if code == "None"
      @code = code

      # promote fields to instance variables with metaprogramming
      data["attributes"].each do |k, v|
        sym = ("@" + k).intern
        self.instance_variable_set sym, v
        next if @@has_attribs
        Preset.class_eval{attr_reader k.intern}
      end

      @@has_attribs = true

      @provider_type = safe_id data["relationships"]["providerType"]
      provider = ProviderCache.envs[@remote].find_by_id @provider_type

      @file_suffix = ProviderCache.to_file_ext provider
      @path = @name + "." + @file_suffix

      @metadata = {
        "providerName" => provider["name"],
        "providerSettings" => @providerSettings,
      }
      remove_instance_variable(:@providerSettings)

      #special zip handling for usability
      if @providerDataFilename and @providerDataFilename.end_with? ".zip"
        @path = @path + ".zip"
      end
    end
  end

  # Get id based on name
  def get_id_on_env env=@remote
    @remote_id ||= {env => @id}
    return @remote_id[env] if @remote_id[env]
    id = RallyTools.get_rally_id_for_preset_name(@name, env)
    @remote_id[env] = id
  end
  def put_code_on_env env=@remote
    id = get_id_on_env env

    update_path = "/presets/#{id}/providerData"
    begin
      response = RallyTools.make_api_request(update_path, env, body: code_binary(), put: true)
    rescue HTTPRequestError => e
      p e.msg
    end
  end

  def provider_name; @metadata["providerName"]; end
  def provider_settings; @metadata["providerSettings"]; end

  def create_payload env
    raise RallyMatchNotFoundError if not provider_name
    provider_id = ProviderCache.envs[env].find_id_by_name provider_name

    {
      data: {
        type: "presets",
        attributes: {
          name: @name,
          providerSettings: provider_settings,
        },
        relationships: {
          providerType: {
            data: {
              id: provider_id,
              type: "providerTypes",
            },
          }
        }
      }
    }
  end

  # Use this function to create or update a preset on a remote respoistory
  def patch_on_env env=@remote
    payload = create_payload env
    id = get_id_on_env env
    return create_on_env env if not id

    update_path = "/presets/#{id}"
    return RallyTools.make_api_request(update_path, env, payload: payload, patch: true)
  end

  def create_on_env env
    payload = create_payload env
    path = "/presets"
    RallyTools.make_api_request(path, env, payload: payload)
  end

  # file path constants
  def get_path
    ENV["rally_repo_path"] + "/silo-presets/" + @path
  end
  def get_metadata_path
    ENV["rally_repo_path"] + "/silo-metadata/" + @path + "_md.json"
  end

  # this is special handling for binary files, because the rally api returns
  # binaries as python-type binary encoded strings.
  def code_binary
    if code_binary?
      return @code[8..-1].unpack("m")
    else
      return @code
    end
  end
  def code_binary?
    return @code[0..8] == "=BASE64="
  end

  # write both the preset code and the preset metadata to a file
  def save
    File.open(get_metadata_path, "w") do |f|
      f.write(JSON.pretty_generate @metadata)
    end
    File.open(get_path, "w") do |f|
      f.write(code_binary) if @code
    end
  end

  # read metadata values written into a preset's comments
  def parse_preset_for_name
    # parse the preset's name value

    if(@path.end_with?(".jinja") || @path.end_with?(".json"))
      name = File.basename(@path, ".*")
      name.gsub!("_", " ")
      name.gsub!("-", " ")
      return name
    end

    #pass it along to see if it is in the filename
    name = find_name_in_preset
    if not name
      raise InvalidPresetException.new("No metadata key 'name' found in preset: #{@path}")
    end
    name
  end
  def find_test_in_preset
    test_matches = /autotest:\s([\w\d. \/]+),\s?([\w\d. \/]+),\s?([\w\d. \/]+)[\r\s]?$/.match(@code)
    begin
      return {
        rule_name: test_matches[1],
        movie_name: test_matches[2],
        env: test_matches[3].intern
      }
    rescue NoMethodError
      return nil
    end
  end
  def find_name_in_preset
    name_matches = /name:\s([\w\d. \/]+)[\r\s]?$/.match(@code)
    begin
      name = name_matches[1]
      return name
    rescue NoMethodError
      return nil
    end
  end

  # takes a list of strings, returns back all strings that were found in the code
  def parse_code_for_strings string_list
    return [] if not @code

    matches = []

    string_list.each do |x|
      b = Regexp.new x
      b =~ @code
      next if not $~

      matches << x
    end

    matches
  end

  def self.find_by_id env, id
    Preset[env].find {|x| x.id == id}
  end
  def self.find_by_name env, name
    Preset[env].find {|x| x.name == name}
  end
  # This produces our standard name header,
  def prepend_preset_name_to_code
    return if not @code
    # Only prepend name to evaluates, although other comment formats may be ok.
    return if provider_name != "SdviEvaluate"
    throw if not @name
    return if find_name_in_preset

    name_search = Regexp.new "^#{@name}$"
    if name_search =~ @code
      @code.sub! @name, "name: #{@name}"
    elsif @code.start_with? "'''"
      @code.sub! "'''", "'''\nname: #{@name}\n"
    else
      @code.prepend "'''\nname: #{name}\n'''\n"
    end
  end

  def self.download_all env, suppress: false, updatedSince: 0
    return [] if updatedSince != 0
    #ignore updatedSince for now

    RallyTools.download_all("/presets?page=1p10", env, suppress: suppress) do |x|
      {
        "data" => x,
        "code" => Preset.get_preset_code(x['id'], env)
      }
    end
  end

  def self.get_preset_code(preset_id, env)
    return "--code--" if true

    body, resp = RallyTools.make_api_request("/presets/#{preset_id}/providerData", env, never_json: true, return_http: true)
    if resp.headers["Content-Type"] == "application/octet-stream"
      body = "=BASE64=" + [body].pack("m")
    end

    body
  end

  class << self
    def [] env
      @@all_presets ||= {}
      @@all_presets[env] ||= Preset.cache_env env
      @@all_presets[env]
    end
    def cache_env env
      data = Preset.serialized_download "preset", env
      data.map! {|x| Preset.new :silo, x["data"], x["code"]}
      #data.each {|x| x.map_ids_to_names}
      data
      #Preset.serialized_save data
    end
  end
end
