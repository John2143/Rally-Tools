require_relative "./rally-tools.rb"
require_relative "./serializable.rb"
require "json"

class ProviderCache
  attr_reader :providers, :file

  class << self
    attr_accessor :envs
    ProviderCache.envs = {}
  end

  def initialize env
    @env = env
    @file = File.join DownloadableCache.dirname, "providers_cache_#{@env}.json"
    begin
      #raise SystemCallError.new "b"
      @providers = JSON.parse IO.read(@file)
      p "providers from file", @file
    rescue SystemCallError
      map = {}

      RallyTools.download_all("/providerTypes?page=1p25", @env, suppress:false) do |x|
        resp = RallyTools.make_api_request(nil, @env, path_override: x["links"]["editorConfig"], suppress: true)
        #lang = resp
        key = map[x["id"].to_s] = {
          "config" => resp,
          "data" => x
        }
        key["name"] = key["data"]["attributes"]["name"]
      end

      p "Wrote file"
      File.open(@file, "w") {|f| f.write(JSON.pretty_generate(map))}

      @providers = map
    end

    ProviderCache.envs[@env] = self
  end
  def find_by_id id
    @providers[id.to_s]
  end
  def self.to_file_ext provider
    throw "nil provider" if not provider
    lang = provider["config"]["lang"] rescue nil
    return "raw" if not lang
    return "py" if lang == "python"
    lang
  end
  def map_by_id to, id
    name = (find_by_id id)["name"] rescue nil
    return nil if not name
    ProviderCache.envs[to].find_by_name name
  end
  def find_id_by_name name
    obj = find_by_name name
    return nil if not obj
    obj["data"]["id"]
  end
  def find_by_name name
    @providers.each do |id, x|
      return x if x["name"] == name
    end
    return nil
  end
end

ProviderCache.new :UAT
ProviderCache.new :DEV
#ProviderCache.new :PROD

#unit testing
if __FILE__ == $0
  id = ProviderCache.envs[:UAT].find_by_name  "SdviEvaluate"
  id = id["data"]["id"]
  p id
  id = ProviderCache.envs[:UAT].map_by_id :DEV, id
  id = id["data"]["id"]
  p id
end
