directions = %w(north east south west)

direction_index = 0
coordinates = [0,0] # x,y

IO.read('input.txt').split(', ').each do |instruction|
  direction_to_turn = instruction[0]

  if direction_to_turn == "R"
    direction_index = direction_index + (direction_index < 3 ? 1 : -3)
  elsif direction_to_turn == "L"
    direction_index = direction_index - (direction_index > 0 ? 1 : -3)
  else
    raise "Huh direction to turn wasn't left or right"
  end

  case directions[direction_index]
  when 'north'
    coordinates[1] = coordinates[1] + instruction[1..-1].to_i
  when 'east'
    coordinates[0] = coordinates[0] + instruction[1..-1].to_i
  when 'south'
    coordinates[1] = coordinates[1] - instruction[1..-1].to_i
  when 'west'
    coordinates[0] = coordinates[0] - instruction[1..-1].to_i
  end
end

puts coordinates.map(&:abs).reduce(0, :+) # Very functional, but pretty over the top