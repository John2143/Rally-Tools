require_relative "./rally-tools.rb"
require_relative "./serializable.rb"
require_relative "./preset.rb"
require "json"

class Rule < Serializable
  extend DownloadableCache

  @@has_attribs = false
  attr_reader :passNext, :errorNext, :presetType, :preset, :id
  attr_reader :cpassNext, :cerrorNext, :cpreset

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
    @cpassNext  = self.class.find_by_id @passNext
    @cerrorNext = self.class.find_by_id @errorNext
    @cpreset    = Preset.find_by_id @preset

    if @cerrorNext == nil and @errorNext != nil \
    or @cpassNext  == nil and @passNext  != nil \
    or @cpreset    == nil and @preset    != nil \

      puts "Fatal rule error on #{@name}"

    end
  end
  def self.find_by_id id
    Rule.all_rules.find {|x| x.id == id}
  end
  def self.find_by_name name
    Rule.all_rules.find {|x| x.name == name}
  end
  def self.save
    Rule.serialized_save "rule", Rule.all_rules
  end
end

data = Rule.serialized_download "rule"
data.map! {|x| Rule.new x}
Rule.all_rules = data
Rule.save
