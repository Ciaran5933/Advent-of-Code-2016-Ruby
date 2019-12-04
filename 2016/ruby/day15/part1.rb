input = IO.readlines('input.txt')

class Disc
  def initialize(input)
    _, @positions, _, @start_position = input.scan(/\d+/).map(&:to_i)
  end


  def fall_through?(time)
    (@start_position + time) % @positions == 0
  end

  def to_s
    "#{@positions} #{@start_position}"
  end
end

discs = input.map{ |line| Disc.new(line) }

time = 0

while true
  disc_results = discs.map.with_index { |disc, i| disc.fall_through?(time + i + 1)}
  break if disc_results.all?

  time += 1
end

puts time