# deploy a set of presets to rally
class Deployment

  def initialize(presets, env)
    @presets = presets
    @env = env
    @deployment_results = {successful: [], error: [], messages:[]}
  end

  def get_results()
    return @deployment_results
  end

  def deploy()
    # locate each preset in Rally and attempt updating it
    @presets.each do |preset|
      begin
        id = preset.name
        preset.(id, preset)
        @deployment_results[:successful].append(preset.name)
      rescue RallyMatchNotFoundError => e
        RallyTools::create_preset_in_rally(preset)
        @deployment_results[:error].append(preset.name)
        @deployment_results[:messages].append(e)
      rescue Errors::HTTPRequestError => e
        @deployment_results[:error].append(preset.name)
        @deployment_results[:messages].append(e)
      end

    end
  end


  def save_report()

  end


end
