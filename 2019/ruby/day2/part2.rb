initial_input = IO.read('input.txt').split(',').map(&:to_i)

a = 0
b = 0

input = []

while b < 100
  
  input = initial_input.dup
  
  input[1] = a
  input[2] = b

  input.each_slice(4) do |code|
    break if code[0] == 99

    op = code[0] == 1 ? :+ : :*
      
    input[code[3]] = input[code[1]].send(op, input[code[2]])
  end

  break if input[0] == 19690720

  a += 1
  if a > 99
    a = 0
    b += 1
  end
end

puts "#{a} #{b}", 100 * a + b