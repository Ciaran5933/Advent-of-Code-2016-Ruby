input = IO.readlines('input.txt')
input.map! { |line| line.scan(/\d+/).map(&:to_i) } # turn each line into an array

transposed = input.transpose # Pulls out the columns from the multi-dimensional array. See https://ruby-doc.org/core-2.3.1/Array.html#method-i-transpose

number_of_valid_triangles = 0

transposed.each do |column|
  column.each_slice(3) do |potential_triangle| # Iterates over the array in slices of 3
    a,b,c = potential_triangle.sort
    number_of_valid_triangles += 1 if c < a + b
  end
end

puts number_of_valid_triangles