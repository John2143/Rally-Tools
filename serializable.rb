require "json"

#this function will return the id of a rally representation, or nil if not found
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
      #ignore variables that start with '_'
      next if strvar.start_with? "_"
      hash[strvar] = self.instance_variable_get var
    end
    hash.to_json opts
  end
  #this method is not 100% reliable, because some values are not saved
  def from_json_data dict
    dict.each do |var, val|
      self.instance_variable_set ("@" + var), val
    end
  end
end

module DownloadableCache
  class << self
    attr_accessor :dirname, :metadataFilename, :metadata
    DownloadableCache.dirname = ENV["rally_cache_folder"]
    puts DownloadableCache.dirname
    DownloadableCache.metadataFilename = File.join DownloadableCache.dirname, "metadata"
    begin
      DownloadableCache.metadata = JSON.parse IO.read DownloadableCache.metadataFilename
    rescue Errno::ENOENT
      DownloadableCache.metadata = {
        "last_download" => {},
      }
      puts "DL cache file not found. No action"
    end
  end

  def self.metadata_save
    File.open(DownloadableCache.metadataFilename, "w") do |f|
      f.write JSON.pretty_generate(DownloadableCache.metadata)
    end
  end

  def serialized_download type, env
    data = nil
    @ident = "#{type}s_#{env}"
    file = File.join DownloadableCache.dirname, "all_#{@ident}.json"
    begin
      f = File.read(file)
      data = JSON.parse(f)
      puts "Got #{@ident} from file"
    rescue
      puts "Building #{@ident} cache..."
      # call #download_all method in a class
      classname = type.capitalize
      c = Object.const_get(classname)
      data = c.download_all env

      puts "Downloaded"

      p data
      #save the unparsed data
      File.open(file, "w"){|f| f.write JSON.pretty_generate(data)}
      DownloadableCache.metadata["last_downlaod"][@ident] = Time.now.to_i
      DownloadableCache.metadata_save
    end

    data
  end
  # save parsed data
  def serialized_save data
    filepath = File.join(DownloadableCache.dirname, "all_#{@ident}2.json")
    File.open(filepath, "w") {|f| f.write JSON.pretty_generate(data)}
  end
end
