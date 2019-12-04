input = IO.read('input.txt').split(',').map(&:to_i)

input[1] = 12
input[2] = 2

input.each_slice(4) do |code|
  puts input[0] && break if code[0] == 99

  op = code[0] == 1 ? :+ : :*
    
  input[code[3]] = input[code[1]].send(op, input[code[2]])
end

puts input.join(',')
