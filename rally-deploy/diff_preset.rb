require 'optparse'
require 'tempfile'
require 'cgi'
require_relative '../preset.rb'
require_relative './deployment.rb'
require_relative '../rally-tools.rb'

options = {
  :env => :UAT
}

OptionParser.new do |parser|
  parser.on("-f", "--file NAME", "The name of the preset to deploy") do |v|
    options[:file] = v
    p v
  end
  parser.on("-e", "--env NAME", "The name of the working env") do |v|
    options[:env] = v.upcase.intern
    p v
  end
end.parse!

preset = Preset.new(:local, options[:file])
body = RallyTools.make_api_request("/presets?filter=name=#{CGI.escape(preset.name)}", options[:env])
if body['data'].empty?
  p "This file does not exist by this name"
  exit
end

body = RallyTools.make_api_request(nil, options[:env], path_override: body['data'][0]['links']['providerData'], never_json: true)

file = Tempfile.new(["rallydiff", ".py"])
file.write(body)
file.close

file_args = "\"#{options[:file]}\" #{file.path}"

`diff #{file_args}`
exit if $?.exitstatus == 0

exec("vim -d #{file_args}")
