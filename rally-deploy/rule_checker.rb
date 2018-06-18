require_relative "../rule.rb"
require_relative "../preset.rb"

puts "#{Rule.all_rules.count} rules"
puts "#{Preset.all_presets.count} presets"

Rule.all_rules.each {|x| x.associate_related}
Preset.all_presets.each {|x| x.prepend_preset_name_to_code}

def calculate_supply_chain start
  rule_queue = [Rule.find_by_name(start)]
  preset_name_queue = []

  rules_processed = []
  rule_names   =   Rule.all_rules  .map {|x| x.name}
  preset_names = Preset.all_presets.map {|x| x.name}
  rule_queue.each do |rule|
    if rule.is_a? String
      rule = Rule.find_by_name rule
    end

    throw if not rule

    next if rules_processed.include? rule
    rules_processed << rule

    rule_queue << rule.cpassNext  if rule.cpassNext
    rule_queue << rule.cerrorNext if rule.cerrorNext
    preset_name_queue << rule.cpreset.name

    rule.next_rules = []
    rule.cpreset.parse_code_for_strings(rule_names).each do |x|
      next_rule = Rule.find_by_name x
      return puts "Fatal error: Rule not found #{x}" if not next_rule
      rule_queue << next_rule
      rule.next_rules << next_rule
    end

    rule.next_presets = []
    rule.cpreset.parse_code_for_strings(preset_names).each do |x|
      preset_name_queue << x
      rule.next_presets << x
    end
  end

  rule_queue.uniq!
  preset_name_queue.uniq!

  preset_queue = preset_name_queue.map! {|x| Preset.find_by_name x}

  return rule_queue, preset_queue
end

files = [
  "OR00 File Type Determiner",
  "AS100 QC Task Handler",
  "AS200 Recontribution Task Handler",
  "PLV - On Metadata Change",
  "OR TMD SNS Message Handler",
]

files.each do |name|
  rules, presets = calculate_supply_chain name
  puts "#{rules.count} rules (#{presets.count} presets) in supply chain from #{rules.first.name}"
  presets.each do |x|
    x.save_code
  end
end

#Rule.save
