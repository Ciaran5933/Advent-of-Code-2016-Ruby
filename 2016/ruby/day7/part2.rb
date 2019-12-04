input = IO.readlines('input.txt')

number_supports_ssl = 0

input.each do |line|
  chars = line.strip.chars

  in_square_brackets = false
  aba_list = []
  bab_list = []

  chars.each.with_index do |item, i|
    if item == '['
      in_square_brackets = true
      next
    end

    if item == ']'
      in_square_brackets = false
      next
    end

    next unless i >= 2
    next unless chars[i] != chars[i-1]
    next unless chars[i] == chars[i-2]

    if in_square_brackets
      bab_list << chars[i-2..i].join
    else
      aba_list << chars[i-2..i].join
    end
  end

  number_supports_ssl += 1 if aba_list.any? {|aba| bab_list.include?("#{aba[1]}#{aba[0]}#{aba[1]}") }
end

puts number_supports_ssl