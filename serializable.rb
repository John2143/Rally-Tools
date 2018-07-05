require "json"

def safe_id r
  dat = r["data"]
  return if dat == nil
  dat["id"].to_i
end

class Serializable
  def to_json opts={}
    hash = {}
    self.instance_variables.each do |var|
      #remove starting @
      strvar = var[1..-1]
      next if strvar.start_with? "_"
      hash[strvar] = self.instance_variable_get var
    end
    hash.to_json opts
  end
  def from_json_data dict
    dict.each do |var, val|
      self.instance_variable_set ("@" + var), val
    end
  end

  public
end

module DownloadableCache
  class << self
    attr_accessor :dirname
    DownloadableCache.dirname = File.dirname __FILE__
  end

  def serialized_download type, env
    data = nil
    @ident = "#{type}s_#{env}"
    file = File.join DownloadableCache.dirname, "all_#{@ident}s_.json"
    begin
      f = File.read(file)
      data = JSON.parse(f)
      puts "Got #{@ident} from file"
    rescue
      puts "Building #{@ident} cache..."
      classname = type.capitalize
      c = Object.const_get(classname)
      data = c.download_all env
      puts "Downloaded"
      File.open(file, "w"){|f| f.write JSON.pretty_generate(data)}
    end

    data
  end
  def serialized_save data
    File.open(File.join(DownloadableCache.dirname, "all_#{@ident}2.json"), "w") {|f| f.write JSON.pretty_generate(data)}
  end
end
