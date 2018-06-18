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
      hash[var[1..-1]] = self.instance_variable_get var
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
  def serialized_download type
    data = nil
    @dirname = File.dirname __FILE__
    file = File.join @dirname, "all_#{type}s.json"
    begin
      f = File.read(file)
      data = JSON.parse(f)
      puts "Got #{type}s from file"
    rescue
      puts "Building #{type} cache..."
      methodname = "download_all_#{type}s"
      data = RallyTools.public_send(methodname)
      puts "Downloaded"
      File.open(file, "w"){|f| f.write JSON.pretty_generate(data)}
    end

    data
  end
  def serialized_save type, data
    File.open(File.join(@dirname, "all_#{type}s2.json"), "w") {|f| f.write JSON.pretty_generate(data)}
  end
end
