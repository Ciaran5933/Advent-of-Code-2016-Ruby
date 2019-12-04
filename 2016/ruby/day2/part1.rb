input = IO.readlines('input.txt')

button = 5

code = ''
input.each do |line|
  directions = line.strip.split(//)

  directions.each do |dir|
    case dir
    when 'U'
      button -= 3 if button > 3
    when 'R'
      button += 1 if button % 3 != 0
    when 'D'
      button += 3 if button < 7
    when 'L'
      button -= 1 if button % 3 != 1
    else
      raise "Huh incorrect direction"
    end
  end
  code += button.to_s
end

puts code