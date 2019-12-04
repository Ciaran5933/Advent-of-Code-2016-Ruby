require 'digest'

input = File.read('input.txt')

open_chars = %w(b c d e f)

# Without outside walls
location = [
            %w(S - . - . - .),
            %w(| # | # | # |),
            %w(. - . - . - .),
            %w(| # | # | # |),
            %w(. - . - . - .),
            %w(| # | # | # |),
            %w(. - . - . - V)
           ]

states = [[0, 0, '']]

valid_paths = []

def increment_based_on_direction_number(x, y, direction_number)
  case direction_number
  when 0
    return if y < 2
    y -= 2
    direction = 'U'
  when 1
    return if y >= 6
    y += 2
    direction = 'D'
  when 2
    return if x < 2
    x -= 2
    direction = 'L'
  when 3
    return if x >= 6
    x += 2
    direction = 'R'
  end
  return [x, y, direction]
end


while !states.empty?
  x, y, path = states.shift

  if x == 6 and y == 6
    valid_paths << path
    next
  end

  hex = Digest::MD5.hexdigest(input + path)

  hex[0..3].chars.each.with_index do |char, direction_number|
    next unless open_chars.include?(char)
    next unless increment_based_on_direction_number(x, y, direction_number) #lazy
    new_x, new_y, direction = increment_based_on_direction_number(x, y, direction_number)
    states << [new_x, new_y, path + direction]
  end
end

puts valid_paths.last.length