require_relative "../rule.rb"
require_relative "../preset.rb"

puts "#{Rule.all_rules.count} rules"
puts "#{Preset.all_presets.count} presets"

Rule.all_rules.each {|x| x.associate_related}
Preset.all_presets.each {|x| x.prepend_preset_name_to_code}

def calculate_supply_chain start
  rule_queue = [Rule.find_by_name(start)]
  preset_name_queue = []

  return nil, nil if not rule_queue.first

  rules_processed = []
  rule_names   =   Rule.all_rules  .map {|x| x.name}
  preset_names = Preset.all_presets.map {|x| x.name}

  rule_queue.each do |rule|
    rulename = nil
    if rule.is_a? String
      rulename = rule
      rule = Rule.find_by_name rulename
    else
      rulename = rule.name
    end

    if not rule
      print "unsupported rule #{rulename}"
      next
    end

    next if rules_processed.include? rule
    rules_processed << rule

    rule_queue << rule._cpassNext  if rule._cpassNext
    rule_queue << rule._cerrorNext if rule._cerrorNext
    preset_name_queue << rule._cpreset.name

    rule.next_rules = []
    rule._cpreset.parse_code_for_strings(rule_names).each do |x|
      next_rule = Rule.find_by_name x
      return puts "Fatal error: Rule not found #{x}" if not next_rule
      rule_queue << next_rule
      rule.next_rules << next_rule
    end

    rule.next_presets = []
    rule._cpreset.parse_code_for_strings(preset_names).each do |x|
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
  "ORHIVE Get HIVE API Data",
  "AS100 QC Task Handler",
  "AS200 Recontribution Task Handler",
  "PLV - On Metadata Change",
  "OR TMD SNS Message Handler",
]

files.each do |name|
  rules, presets = calculate_supply_chain name
  if not rules
    puts "Supply chain not available: #{name}"
  else
    puts "#{rules.count} rules (#{presets.count} presets) in supply chain from #{rules.first.name}"
    presets.each do |x|
      x.save
    end
    rules.each do |x|
      x.save
    end
  end
end

#Rule.save
