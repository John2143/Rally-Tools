# deploy a set of presets to rally
class Deployment

  def initialize(presets, env, test)
    @presets = presets
    @env = env
    @test = test
    @deployment_results = {successful: [], error: [], messages:[]}
  end

  def get_results()
    return @deployment_results
  end

  def deploy()
    # locate each preset in Rally and attempt updating it
    @presets.each do |preset|
      begin
        preset.put_code_on_env @env
        @deployment_results[:successful].append(preset.name)
      rescue RallyMatchNotFoundError => e
        begin
          preset.create_on_env @env
          preset.put_code_on_env @env
          @deployment_results[:successful].append(preset.name + " (create)")
        rescue StandardError => e
          @deployment_results[:error].append(preset.name)
          @deployment_results[:messages].append(e)
        end
      rescue Errors::HTTPRequestError => e
        @deployment_results[:error].append(preset.name)
        @deployment_results[:messages].append(e)
      end
    end
    if @test
      puts "Starting test"
      puts @test
      RallyTools.make_api_request("/workflows", @test[:env], payload: RallyTools.new_jobs_payload(nil, @test[:movie_name], @test[:rule_name]))
    end
  end


  def save_report()

  end


end
