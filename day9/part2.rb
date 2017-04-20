def calculate_decompressed_length(string)
  decompressed_length = 0
  while string && 0 < string.length do
    unless string[0] == '('
      decompressed_length += 1
      string = string[1..-1]
      next
    end

    close_parenthesis_index = string =~ /\)/
    chars_to_repeat, repeat_times = string[1..close_parenthesis_index-1].split('x').map(&:to_i)

    string = string[close_parenthesis_index+1..-1]
    chars = string[0..chars_to_repeat-1]

    string = string[chars_to_repeat..-1]

    decompressed_length += calculate_decompressed_length(chars) * repeat_times
  end

  return decompressed_length
end


input = File.read('input.txt')

puts calculate_decompressed_length(input)