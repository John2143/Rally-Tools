require_relative './errors.rb'
require_relative "./rally-tools.rb"
require_relative "./serializable.rb"
require_relative "./provider_cache.rb"

require "json"

class Preset < Serializable
  extend DownloadableCache
  EvaluateProvider = 13

  attr_accessor :name, :code
  attr_reader :type, :id, :rule_matches
  @path
  @@has_attribs = false

  class << self
    attr_accessor :all_presets, :code_match
    # this matches rules like "OR132 Blah blah"
    #Preset.code_match = /(([A-Z]+ )?[A-Z]{1,3}\d{2,5}\w{0,3}?\s(\- )?[\w .\d-]+)/
  end

  #args:
  #  :local, <path>
  #  :silo, <attributes>, <code>
  #  :
  def initialize type, data, code= ''
    @type = type
    if @type == :local
      @path = data
      @code = RallyTools::open_file(@path)
      @name = parse_preset_for_name
    elsif @type == :silo
      @path = nil
      @id = data["id"]
      code = nil if code == "None"
      @code = code

      # @name = <<set inside this loop>>
      # promote fields to instance variables with metaprogramming
      data["attributes"].each do |k, v|
        sym = ("@" + k).intern
        self.instance_variable_set sym, v
        next if @@has_attribs
        Preset.class_eval{attr_reader k.intern}
      end
      @@has_attribs = true

      @provider_type = safe_id data["relationships"]["providerType"]
      @file_suffix = ProviderCache.to_file_ext @provider_type

      @path = @name + "." + @file_suffix
    end
  end

  def save_code
    file = ENV["rally_repo_path"] + "/silo-presets/" + @path
    #p file
    File.open(file, "w") do |f|
      f.write(@code)
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
  def find_name_in_preset
    name_matches = /name:\s([\w\d. ]+)[\r\s]?$/.match(@code)
    begin
      name = name_matches[1]
      return name
    rescue NoMethodError
      return nil
    end
  end

  def parse_code_for_strings string_list
    matches = []

    string_list.each do |x|
      b = Regexp.new x
      b =~ @code
      next if not $~

      matches << x
    end

    matches
  end

  def self.find_by_id id
    Preset.all_presets.find {|x| x.id == id}
  end
  def self.find_by_name name
    Preset.all_presets.find {|x| x.name == name}
  end
  def prepend_preset_name_to_code
    return if not @code
    return if @provider_type != EvaluateProvider
    throw if not @name
    return if find_name_in_preset
    name_search = Regexp.new @name
    if name_search =~ @code
      @code.sub! @name, "name: #{@name}"
    elsif @code.start_with? "'''"
      @code.sub! "'''", "'''\nname: #{@name}\n"
    else
      @code.prepend "'''\nname: #{name}\n'''\n"
    end
  end
end

data = Preset.serialized_download "preset"
data.map! {|x| Preset.new :silo, x["data"], x["code"]}
Preset.all_presets = data
Preset.serialized_save "preset", data
