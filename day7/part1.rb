input = IO.readlines('input.txt')

number_supports_tls = 0

input.each do |line|
  chars = line.strip.chars

  in_square_brackets = false
  supports_tls = false

  chars.each.with_index do |item, i|
    if item == '['
      in_square_brackets = true
      next
    end

    if item == ']'
      in_square_brackets = false
      next
    end

    next if supports_tls && !in_square_brackets

    next unless i >= 3
    next unless chars[i] != chars[i-1]
    next unless chars[i-1] == chars[i-2]
    next unless chars[i] == chars[i-3]

    if in_square_brackets
      break
    else
      supports_tls = true
    end
  end

  number_supports_tls += 1 if supports_tls && !in_square_brackets
end

puts number_supports_tls