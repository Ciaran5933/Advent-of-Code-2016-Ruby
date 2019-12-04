input = IO.readlines('input.txt')

frequencies = [{},{},{},{},{},{},{},{}]

input.each do |line|
  line.strip.chars.each.with_index do |char, i|
    if frequencies[i][char]
      frequencies[i][char] += 1
    else
      frequencies[i][char] = 1
    end
  end
end

most_frequent = frequencies.map do |f|
  f.to_a.sort {|x,y| x[1] <=> y[1] }.last[0]
end
puts most_frequent.join