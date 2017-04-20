input = IO.readlines('input.txt')

# No idea what I'm doing

bot_instructions = {}
value_instructions = {}

input.each do |line|
  if line =~ /value/
    value, bot = line.scan(/(\d{1,})/).flatten.map(&:to_i)
    if value_instructions[bot]
      value_instructions[bot] = value_instructions[bot] << value
    else
      value_instructions[bot] = [value]
    end
  else
    a, b, c = line.scan(/(\d{1,})/).flatten.map(&:to_i) # bots
    bot_instructions[a] = [b,c]
  end
end

while true do
  bot = value_instructions.dup.keep_if { | k,v| v.length > 1 }.keys[0]

  values = value_instructions[bot].sort
  if values == [17, 61]
    puts bot
    break
  end

  to_bots = bot_instructions[bot]

  value_instructions[bot] = []

  to_bots.each.with_index do |to_bot, i|
    value = values[i]
    if value_instructions[to_bot]
      value_instructions[to_bot] = value_instructions[to_bot] << value
    else
      value_instructions[to_bot] = [value]
    end
  end
end