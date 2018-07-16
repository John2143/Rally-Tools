require_relative "./rally-tools.rb"
require_relative "./rule.rb"
require "tty-prompt"
require "optparse"

class AbortCommitError < StandardError
end

options = {
  env: :UAT,
  type: "none",
}

OptionParser.new do |parser|
  parser.on("-e", "--env NAME", "The name of the working env") do |v|
    options[:env] = v.upcase.intern
    p v
  end
  parser.on("-t", "--type prompt_type", "Prompt type: tty, atom") do |v|
    options[:type] = v
    p v
  end
end.parse!


def tty_prompt_rules rules
  prompt = TTY::Prompt.new
  return [] if not prompt.yes? "Did you modify rules? (Y/n)"

  #map the preset list to a hash so that prompt will like it
  new_hash = {}
  rules.each {|x| new_hash[x.name] = x}

  begin
    return prompt.multi_select "Rules modified (Space = select, Enter = done):\nSelected: ", new_hash, filter: true
  rescue TTY::Reader::InputInterrupt
    puts "\nInput Canceled"
    raise AbortCommitError
  end
end

def prompt options
  # Get time of last commit
  unix_commit_time = Integer(`git log --format="%at" -n1`) * 1000

  # update rules here
  p options[:env]
  #p Rule[options[:env]]
  rules = Rule[options[:env]].select {|rule| rule.updatedAt >= unix_commit_time}

  if options[:type] == "tty"
    tty_prompt_rules rules
  #elsif options[:type] = "atom"
    #atom_prompt_rules
  else
    puts "failed to find sutable function for type '#{options[:type]}'."
  end
end

begin
  prompt options
rescue AbortCommitError
  puts "Commit aborted"
  exit 1
end
