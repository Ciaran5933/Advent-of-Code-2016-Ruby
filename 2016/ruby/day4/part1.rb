input = IO.readlines('input.txt')

sector_id_sum = input.reduce(0) do |sum, line|
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

  sorted_frequencies.first(5).map(&:first).join == checksum ? sum + sector_id.to_i : sum
end

puts sector_id_sum