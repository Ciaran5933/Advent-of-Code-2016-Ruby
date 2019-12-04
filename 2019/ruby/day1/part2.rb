puts IO.readlines("input.txt").sum { |line| 
  a = line.to_i
  b = 0
  loop do 
    a = a / 3 - 2
    b = a + b
    break unless a > 6
  end
  b
}