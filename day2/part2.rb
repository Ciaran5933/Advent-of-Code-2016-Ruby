input = IO.readlines('input.txt')

location = 10

keypad =  [
            nil, nil,  1,  nil, nil,
            nil,  2,   3,   4,  nil,
             5,   6,   7,   8,   9,
            nil, 'A', 'B', 'C', nil,
            nil, nil, 'D', nil, nil
          ]

code = ''
input.each do |line|
  directions = line.strip.split(//)

  directions.each do |dir|
    case dir
    when 'U'
      next if location <= 4 # next if it is the top row
      location -= 5 if keypad[location - 5]
    when 'R'
      next if location % 5 == 4 # next if it is the last column
      location += 1 if keypad[location + 1]
    when 'D'
      next if location >= 20 # next if it is the bottom row
      location += 5 if keypad[location + 5]
    when 'L'
      next if location % 5 == 0 # next if it is the first row
      location -= 1 if keypad[location - 1]
    else
      raise "Huh incorrect direction"
    end
  end
  code += keypad[location].to_s
end

puts code