# The beginning of a set of tools to make working with Rally easier.
require_relative './errors.rb'
require 'http'
require 'json'
require 'pry'
require 'yaml'

class HTTPRequestError < StandardError
  attr_reader :msg
  @msg = nil
  def initialize(resp)
    @msg = "Bad response from HTTP Request, status code #{resp.code}, body: #{resp.body}"
  end
  def to_str
    @msg
  end
end

class InvalidPresetException < StandardError
  attr_reader :object

  def initialize(object)
    @object = object
  end
end

class RallyMatchNotFoundError < StandardError
end

class RallyPRODModifyError < StandardError
end

class RallyTools
  def self.make_api_request(path, env_name, path_override: nil, payload: nil, one_line: false, suppress: false, patch: false, put: false, never_json: false)
    puts "Possibly unsuppored env #{env_name}" if not [:DEV, :UAT, :PROD].include? env_name
    rally_api_key = ENV["rally_api_key_#{env_name}"]
    rally_api = ENV["rally_api_url_#{env_name}"]
    return puts "Unsupported env #{env_name}" if not rally_api

    path = path_override || rally_api + path
    endchar = one_line ? "\t" : "\n"

    # make the request
    print "Making request for path: #{path} #{endchar}" if !suppress
    if payload
      raise RallyPRODModifyError if env_name == "PROD" and ENV["rally_allow_modify_PROD"] != "allowed"

      if patch
        resp = HTTP.accept(:json).auth("Bearer " + rally_api_key).patch(path, json: payload)
      elsif put
        resp = HTTP.accept(:json).auth("Bearer " + rally_api_key).put(path, json: payload)
      else
        resp = HTTP.accept(:json).auth("Bearer " + rally_api_key).post(path, json: payload)
      end
    else
      resp = HTTP.accept(:json).auth("Bearer " + rally_api_key).get(path)
    end

    # check for a successful response
    if ![200, 201, 204].include?(resp.code)
      p resp
      raise HTTPRequestError.new(resp)
    end

    # parse response body into hash
    body = nil
    begin
      raise JSON::ParserError if never_json
      body = JSON[resp.body]
    rescue JSON::ParserError
      body = resp.body.to_s
    end
    return body
  end

  def self.get_rally_id_for_movie_name(movie_name, env)
    movie_search_path = "/movies?filter=nameContains=#{movie_name}"
    body = self.make_api_request(movie_search_path, env)
    id = nil
    begin
      id = body['data'][0]['id']
    rescue NoMethodError
      raise RallyMatchNotFoundError.new
    end
    return id
  end

  def self.get_rally_id(path, env)
    begin
      body = self.make_api_request(path, env)
    rescue HTTPRequestError => e
      p e.msg
    end
    id = nil
    begin
      id = body['data'][0]['id']
    rescue NoMethodError
      raise RallyMatchNotFoundError.new
    end
    return id
  end
  def self.get_rally_id_for_rule_name(rule_name, env)
    self.get_rally_id"/workflowRules?filter=name=#{URI::escape(rule_name)}", env
  end
  def self.get_rally_id_for_preset_name(preset_name, env)
    self.get_rally_id "/presets?filter=name=#{URI::escape(preset_name)}", env
  end

  def self.get_metadata_for_movie_id(movie_id, env, suppress: false)
    metadata_path = "/movies/#{movie_id}/metadata/Metadata"
    response = self.make_api_request(metadata_path, env, suppress: suppress)
    begin metadata = response['data']['attributes']['metadata'] rescue NoMethodError end
    return metadata
  end

  def self.patch_metadata_for_movie_id(movie_id, metadata_obj, env)
    metadata_path = "/movies/#{movie_id}/metadata/Metadata"
    response = self.make_api_request(metadata_path, env, payload: metadata_obj, patch: true)
  end

  def self.set_recontribution_status_metadata(movie_id, status)
    status_reset_metadata = {
      data: {
        id: "Metadata",
        type: "metadata",
        attributes: {
          usage: "Metadata",
          metadata: {
            "Recontribution Status" => status
          }
        }
      }
    }
    RallyTools.patch_metadata_for_movie_id(movie_id, status_reset_metadata)
  end

  def self.poll_until_metadata_equals(movie_id, key, value)
    movie_metadata = nil
    loop do
      print "Polling for Recontribution status on movie #{movie_id}:\t"
      movie_metadata = RallyTools.get_metadata_for_movie_id(movie_id, suppress: true)
      status = movie_metadata['Recontribution Status'] || "not started"
      print "status: #{status} \t"
      break if movie_metadata['Recontribution Status'] == 'complete'
      RallyTools.wait_and_animate(5)
      print("\n")
    end
    puts "###### Complete"
    puts 'Resetting Recontribution Status Metadata'
    RallyTools.set_recontribution_status_metadata(movie_id, "test complete")
    return movie_metadata
  end

  def self.wait_and_animate(iterations)
    iterations.times do
      sleep(1)
      print('.')
    end
  end

  def self.new_jobs_payload(init_data, filename, rule)
    return {
      "data" =>  {
        "type" => "workflows",
        "attributes" =>  {
          "initData" => init_data.to_json
        },
        "relationships" => {
          "movie" => {
            "data" => {
              "type" => "movies",
              "attributes" => {
                "name" => filename
              }
            }
          },
          "rule" => {
            "data" => {
              "type" => "rules",
              "attributes" => {
                "name" => rule
              }
            }
          }
        }
      }
    }
  end

  def self.get_preset_code(preset_id, env)
    resp = RallyTools.make_api_request("/presets/#{preset_id}/providerData", env, never_json: true)
  end

  def self.get_next_page(response)
    begin
      return response['links']['next'] rescue NoMethodError
    end
  end

  def self.download_all(resource, env, suppress: false)
    data = []
    resp = RallyTools.make_api_request(resource, env, suppress: suppress)
    resp["data"].each do |x|
      data << yield(x)
    end
    while RallyTools.get_next_page(resp) do
      #break
      resp = RallyTools.make_api_request(nil, env, path_override: RallyTools.get_next_page(resp), suppress: suppress)
      resp["data"].each do |x|
        data << yield(x)
      end
    end
    return data
  end

  def self.parse_preset_from_file(file_path)
    file_name = File::basename(file_path)
    name = /(.*).py/.match(file_name)[1]
    parsed_preset = {}
    code = IO.read(file_name)
    #File.open('path', 'wb') do |fo|
    #    code = fo.read(text)
    #end
    parsed_preset[name] = {code: code, name: name}
    return parsed_preset
  end

  def self.load_all_presets_in_folder(path)
    preset_files = {}
    path = "#{path}/**/*.py"
    puts path
    Dir.glob(path) do |file|
      preset_files.merge!(RallyTools.parse_preset_from_file(file)) if File.file?(file)
    end
    return preset_files
  end

  def self.difference_of_preset_lists(one, two)
    difference = one.dup.delete_if do |k, v|
      two.has_key?(k)
    end
  end

  def self.presets_in_both_lists(one, two)
    difference = one.dup.delete_if do |k, v|
      !two.has_key?(k)
    end
  end

  def self.compare_preset_code_for_differences(one, two, keys_to_compare)
    presets_with_code_difference = keys_to_compare.map do |preset_name|
      puts "Does preset named #{preset_name} have the same code?"
      difference = one[preset_name][:code] != two[preset_name][:code]
      {:name => preset_name} if difference
    end
    presets_with_code_difference.compact
  end

  def self.new_resource_payload(type: nil, attributes: {}, relationships: {})
    payload = {
      data: {
        type: type,
        attributes: attributes,
        relationships: relationships
      }
    }
  end

  # open a file on the file system, raises exception for missing file
  def self.open_file(file_path)
    raise Errors::FileNotFoundException.new("File not Found") if !File.exist?(file_path)
    file_contents = File.open(file_path, 'rb') { |f| f.read }
  end

  def self.rapid_preset_dev(preset_path)
    # open the preset
    # parse the name, the rule and the test content
    # call update preset in rally
    # create a /workflows payload
    # execute it against the filename
  end

end
