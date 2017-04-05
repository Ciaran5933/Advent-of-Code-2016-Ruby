require 'digest'

input = File.read('input.txt')


code = ''
i = 1
while code.length < 8 do
  hex = Digest::MD5.hexdigest(input + i.to_s)
  if hex[0..4] == '00000'
    code << hex[5]
  end
  i += 1
end

puts code