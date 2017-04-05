require 'digest'

input = File.read('input.txt')


code = [nil] * 8
i = 1
decrypted_count = 0

while decrypted_count < 8 do
  hex = Digest::MD5.hexdigest(input + i.to_s)

  # Could do a regex on the hash to pull out first 5 chars, index, character and do an if on those
  code_index = /[0-7]/.match(hex[5]).to_s

  if hex[0..4] == '00000' && code_index != '' && !code[code_index.to_i]
    code[code_index.to_i] = hex[6]
    decrypted_count += 1
  end
  i += 1
end

puts code.join