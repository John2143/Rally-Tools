require_relative "./rally-tools.rb"
require_relative "./serializable.rb"
require_relative "./preset.rb"
require "json"

class Rule < Serializable
  extend DownloadableCache

  @@has_attribs = false
  attr_reader :passNext, :errorNext, :presetType, :preset, :id
  attr_reader :_cpassNext, :_cerrorNext, :_cpreset
  attr_reader :spassNext, :serrorNext, :spreset, :spresetType

  attr_accessor :next_rules, :next_presets
  class << self
    attr_accessor :all_rules
  end

  def initialize r
    # promote fields to instance variables with metaprogramming
    r["attributes"].each do |k, v|
      sym = ("@" + k).intern
      self.instance_variable_set sym, v
      next if @@has_attribs
      Rule.class_eval{attr_reader k.intern}
    end

    @passNext   = safe_id r["relationships"]["passNext"]
    @errorNext  = safe_id r["relationships"]["errorNext"]
    @presetType = safe_id r["relationships"]["providerType"]
    @preset     = safe_id r["relationships"]["preset"]

    @id = r["id"]

    @@has_attribs = true
    #puts "Match error #{@name}" if not (Preset.code_match =~ @name)
  end
  def associate_related
    @_cpassNext  = self.class.find_by_id @passNext
    @_cerrorNext = self.class.find_by_id @errorNext
    @_cpreset    = Preset.find_by_id @preset

    if @_cerrorNext == nil and @errorNext != nil \
    or @_cpassNext  == nil and @passNext  != nil \
    or @_cpreset    == nil and @preset    != nil \

      puts "Fatal rule error on #{@name}"

    end
  end
  def map_ids_to_names
    @spassNext   = @_cpassNext.name if @_cpassNext
    @sErrorNext  = @_cerrorNext.name if @_cerrorNext
    if @_cpreset
      @spreset     = @_cpreset.name
      @spresetType = @_cpreset.provider_name
    end
  end
  def self.find_by_id id
    Rule.all_rules.find {|x| x.id == id}
  end
  def self.find_by_name name
    Rule.all_rules.find {|x| x.name == name}
  end
  def self.save
    Rule.serialized_save Rule.all_rules
  end
  def upload_to env

  end
  def self.download_all env, suppress: false
      data = RallyTools.download_all("/workflowRules?page=1p20", env, suppress: suppress) {|x| x}
      return data
  end
  def patch_on_env env=@remote
    create_on_env env, true
  end
  def create_on_env env=@remote, update=false
    payload = {
      name: @name,
      providerTypeId: (ProviderCache.envs[env].find_by_name @_cpreset.provider_name)["data"]["id"],
      presetId: @_cpreset.get_id_on_env(env),
      description: @description,
      priority: @priority,
    }

    ## TODO Change this when they fix POST /worflowRules. the v2 api is broken so use v1
    rally_api = ENV["rally_api_url_#{env}"]
    rally_api = rally_api[0..-3] + "v1.0/workflow/rules"

    if update
      payload[:passNextId] = RallyTools.get_rally_id_for_rule_name(@spassNext, env) unless not @_cpassNext
      payload[:errorNextId] = RallyTools.get_rally_id_for_rule_name(@serrorNext, env) unless not @_cerrorNext
      rally_api = "#{rally_api}/#{RallyTools.get_rally_id_for_rule_name(@name, env)}"
    end

    begin
      response = RallyTools.make_api_request(nil, env, path_override: rally_api, payload: payload, put: update)
      return response
    rescue HTTPRequestError => e
      p e.msg
    end
  end
  def get_path
    ENV["rally_repo_path"] + "/silo-rules/" + @name + ".json"
  end
  def save
    File.open(get_path, "w") do |f|
      f.write(JSON.pretty_generate({
        "description" => @description,
        "name" => @priority,
        "starred" => @starred,
        "updatedAt" => @updatedAt,
        "passNext" => @spassNext,
        "errorNext" => @serrorNext,
        "preset" => @spreset,
        "presetType" => @spresetType,
      }))
    end
  end
end

data = Rule.serialized_download "rule", :UAT
data.map! {|x| Rule.new x}
Rule.all_rules = data
data.each {|x| x.associate_related}
data.each {|x| x.map_ids_to_names}
Rule.save
