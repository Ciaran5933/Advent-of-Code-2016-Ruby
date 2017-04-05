input = IO.readlines('input.txt')

real_rooms = []

input.each do |line|
  _, encrypted_name, sector_id, checksum = /(.+)-(\d+)\[(.+)\]/.match(line).to_a

  letters = encrypted_name.gsub('-', '').split('')

  frequencies = letters.inject(Hash.new(0)) do |x, y|
    x[y] = x[y] + 1
    x
  end

  sorted_frequencies = frequencies.to_a.sort do |x, y|
    if x[1] < y[1]
      2
    elsif x[1] > y[1]
      -2
    elsif x[0] > y[0]
      1
    elsif x[0] < y[0]
      -1
    else
      0 # not possible
    end
  end

  real_rooms << [encrypted_name, sector_id] if sorted_frequencies.first(5).map(&:first).join == checksum
end

alphabet = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)

decrypted_rooms = real_rooms.map do |encrypted_name, shift|
  name = encrypted_name.chars.map do |char|
    if char == '-'
      ' '
    else
      alphabet[(alphabet.index(char) + shift.to_i) % 26] # perform the cipher shift
    end
  end
  name.join
end

puts real_rooms[decrypted_rooms.index('northpole object storage')][1]