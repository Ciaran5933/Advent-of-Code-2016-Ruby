input = File.read('input.txt')


data = input

# Maybe should change to an array

while data.length < 272
  a = data.clone
  b = data.clone
  b.reverse!.gsub!('1', '#').gsub!('0', '1').gsub!('#', '0')
  data = "#{a}0#{b}"
end

data = data[0..272-1]

checksum = []

while checksum.length.even?
  to_itterate = checksum.any? ? checksum : data.chars
  checksum = []

  to_itterate.each_slice(2) do |a, b|
    if a == b
      checksum << '1'
    else
      checksum << '0'
    end
  end
end

puts checksum.join