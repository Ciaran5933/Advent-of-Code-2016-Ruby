input = IO.readlines('input.txt')

# No idea what I'm doing

bot_instructions = {}
value_instructions = {}
output_values = {}


input.each do |line|
  if line =~ /value/
    value, bot = line.scan(/(\d{1,})/).flatten.map(&:to_i)
    if value_instructions[bot]
      value_instructions[bot] = value_instructions[bot] << value
    else
      value_instructions[bot] = [value]
    end
  else
    la, lb, lc = line.scan(/(bot|output)/).flatten # locations
    a, b, c = line.scan(/(\d{1,})/).flatten.map(&:to_i)
    bot_instructions[a] = [[lb, b],[lc, c]]
  end
end

while true do
  bot = value_instructions.dup.keep_if { | k,v| v.length > 1 }.keys[0]

  break if bot == nil

  values = value_instructions[bot].sort

  to_locations = bot_instructions[bot]

  value_instructions[bot] = []

  to_locations.each.with_index do |to_location, i|
    value = values[i]
    location = to_location[0]
    number = to_location[1]
    if location == 'bot'
      if value_instructions[number]
        value_instructions[number] = value_instructions[number] << value
      else
        value_instructions[number] = [value]
      end
    else
      if output_values[number]
        output_values[number] = output_values[number] << value
      else
        output_values[number] = [value]
      end
    end
  end
end

puts output_values[0][0] * output_values[1][0] * output_values[2][0]