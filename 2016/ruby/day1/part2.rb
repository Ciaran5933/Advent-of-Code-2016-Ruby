visited_locations = [[0,0]] # x,y

directions = %w(north east south west)
direction_index = 0

exit = false

IO.read('input.txt').split(', ').each do |instruction|
  direction_to_turn = instruction[0]

  if direction_to_turn == "R"
    direction_index = direction_index + (direction_index < 3 ? 1 : -3)
  elsif direction_to_turn == "L"
    direction_index = direction_index - (direction_index > 0 ? 1 : -3)
  else
    raise "Huh direction to turn wasn't left or right"
  end

  distance = instruction[1..-1].to_i

  case directions[direction_index]
  when 'north'
    distance.times do
      current_location = visited_locations.last
      new_location = [current_location[0], current_location[1] + 1]
      if visited_locations.include?(new_location)
        puts new_location.map(&:abs).reduce(0, :+)
        exit = true
      end
      visited_locations << new_location
    end
  when 'east'
    distance.times do
      current_location = visited_locations.last
      new_location = [current_location[0] + 1, current_location[1]]
      if visited_locations.include?(new_location)
        puts new_location.map(&:abs).reduce(0, :+)
        exit = true
      end
      visited_locations << new_location
    end
  when 'south'
    distance.times do
      current_location = visited_locations.last
      new_location = [current_location[0], current_location[1] - 1]
      if visited_locations.include?(new_location)
        puts new_location.map(&:abs).reduce(0, :+)
        exit = true
      end
      visited_locations << new_location
    end
  when 'west'
    distance.times do
      current_location = visited_locations.last
      new_location = [current_location[0] - 1, current_location[1]]
      if visited_locations.include?(new_location)
        puts new_location.map(&:abs).reduce(0, :+)
        exit = true
      end
      visited_locations << new_location
    end
  end

  break if exit
end