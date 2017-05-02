input = IO.readlines('input.txt')


i = 0
registers = {
  'a' => 0,
  'b' => 0,
  'c' => 0,
  'd' => 0
}

while i < input.length
  split_input = input[i].split

  case split_input[0]
  when 'cpy'
    x,y = split_input[1..2]
    if registers[x]
      registers[y] = registers[x]
    else
      registers[y] = x.to_i
    end
  when 'inc'
    registers[split_input[1]] += 1
  when 'dec'
    registers[split_input[1]] -= 1
  when 'jnz'
    x, y = split_input[1..2]
    if registers[x] != 0
      i += y.to_i
      next
    end
  end
  i += 1
end

puts "Register a: #{registers['a']}"