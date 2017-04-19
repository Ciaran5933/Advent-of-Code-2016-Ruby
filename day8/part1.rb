class Display
  def initialize(width, height)
    @screen = Array.new(height) { Array.new(width) }
    @height = height
    @width = width
  end

  def show
    @screen.map { |row| puts row.map{ |pixel| pixel ? pixel : '.' }.join }
  end

  def rect(x, y)
    y.times do |i|
      @screen[i].fill('#', 0..x-1)
    end
  end

  def rotate_row(y, amount)
    row = @screen[y]
    row = row[@width-amount..@width] + row[0..@width-(amount+1)]
    @screen[y] = row
  end

  def rotate_column(x, amount)
    column = @screen.map { |row| row[x] }
    column = column[@height-amount..@height] + column[0..@height-(amount+1)]

    column.each.with_index { |item, index| @screen[index][x] = item }
  end

  def count_lit
    puts @screen.inject(0) { |count, row| count + row.compact.count }
  end
end

input = IO.readlines('input.txt')

screen = Display.new(50, 6)

input.each do |line|
  instructions = line.strip.split(' ')

  case instructions[0]
  when 'rect'
    screen.rect(*instructions[1].split('x').map(&:to_i))
  when 'rotate'
    if instructions[1] == 'row'
      y = instructions[2].split('=').last.to_i
      amount = instructions.last.to_i
      screen.rotate_row(y, amount)
    elsif instructions[1] == 'column'
      x = instructions[2].split('=').last.to_i
      amount = instructions.last.to_i
      screen.rotate_column(x, amount)
    end
  end
end

screen.count_lit