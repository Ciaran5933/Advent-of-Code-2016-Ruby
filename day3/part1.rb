valid_triangles = IO.readlines('input.txt').reduce(0) do |x, y|
  a,b,c = y.scan(/\d+/).map(&:to_i).sort
  c < a + b ? x + 1 : x
end

puts valid_triangles