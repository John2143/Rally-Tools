require_relative "./rally-tools.rb"
require_relative "./serializable.rb"
require "json"

class ProviderCache

  @@file = File.join DownloadableCache.dirname, "providers_cache.json"
  begin
    @@providers = JSON.parse IO.read(@@file)
    p "providers from file", @@providers
  rescue SystemCallError
    map = {}

    RallyTools.download_all("/providerTypes?page=1p50", suppress:false) do |x|
      resp = RallyTools.make_api_request(nil, path_override: x["links"]["editorConfig"], suppress: true)
      lang = resp["lang"]
      map[x["id"]] = lang
    end

    File.open(@@file, "w") {|f| f.write(map.to_json)}

    @@providers = map
  end
  def self.to_file_ext num
    lang = @@providers[num.to_s]
    return "raw" if not lang
    lang = "py" if lang == "python"
    lang
  end
end
