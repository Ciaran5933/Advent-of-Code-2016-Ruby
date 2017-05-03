require 'digest'

input = File.read('input.txt')

i = -1
keys = []

seen_threes = {}

while true
  break if keys.length >= 70 && i < keys.last[0] + 1001
  i += 1
  hex = Digest::MD5.hexdigest(input + i.to_s)

  2016.times { hex = Digest::MD5.hexdigest(hex) }

  three_reg = /(.)\1\1/
  five_reg = /(.)\1\1\1\1/

  five_match = hex.scan(five_reg)
  if five_match.length > 0
    five_match.flatten.uniq.each do |char|
      seen_threes[char].keep_if { |v, hex| (i - 1000..i).include?(v)}
      keys += seen_threes[char]
      seen_threes.delete(char)
    end
  end

  if reg_match = hex.match(three_reg)
    char = reg_match[0][0]
    if seen_threes[char]
      seen_threes[char] << [i, hex]
    else
      seen_threes[char] = [[i, hex]]
    end
  end
end

puts keys.sort[63] #64th