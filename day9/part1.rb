input = File.read('input.txt')

decompressed_length = 0

while input && 0 < input.length do
  unless input[0] == '('
    decompressed_length += 1
    input = input[1..-1]
    next
  end
  close_parenthesis_index = input =~ /\)/
  chars_to_repeat, repeat_times = input[1..close_parenthesis_index-1].split('x').map(&:to_i)
  input = input[close_parenthesis_index+1..-1]

  input = input[chars_to_repeat..-1]

  decompressed_length += chars_to_repeat * repeat_times
end

puts decompressed_length