require 'optparse'
require_relative '../preset.rb'
require_relative './deployment.rb'
require_relative './rally_deploy.rb'
# This will hold the options we parse
options = {
  env: :UAT
}

OptionParser.new do |parser|
  parser.on("-f", "--file NAME", "The name of the preset to deploy") do |v|
    options[:file] = v
    p v
  end
  parser.on("-e", "--env NAME", "The env") do |v|
    options[:env] = v.intern
    p v
  end
end.parse!

preset = Preset.new(:local, options[:file])
p preset.find_test_in_preset
deployment = Deployment.new([preset], options[:env], preset.find_test_in_preset)
deployment.deploy()
p deployment.get_results()
