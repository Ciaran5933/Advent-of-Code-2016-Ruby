input = IO.readlines('input.txt')[0].to_i

destination_x = 31
destination_y = 39

maze = [[],[nil,0]]

def wall(x, y, input)
  ((x * x) + (3 * x) + (2 * x * y) + y + (y * y) + input).to_s(2).gsub('0', '').length.odd?
end

def display_maze(maze)
  maze.each do |row|
    puts row.map { |square| square ? square == '#' ? square : 'f' : '.'}.join
  end
end

queue = [[1,1]]

counter = 0

while queue.length > 0
  counter += 1

  x, y = queue.shift

  right = x + 1
  left = x - 1
  up = y - 1
  down = y + 1

  maze << [] if !maze[down]

  if !maze[down][x]
    if wall(x, down, input)
      maze[down][x] = '#'
    else
      maze[down][x] = maze[y][x] + 1
      queue << [x, down]
    end
  end

  if up >= 0 && !maze[up][x]
    if wall(x, up, input)
      maze[up][x] = '#'
    else
      maze[up][x] = maze[y][x] + 1
      queue << [x, up]
    end
  end

  if left >= 0 && !maze[y][left]
    if wall(left, y, input)
      maze[y][left] = '#'
    else
      maze[y][left] = maze[y][x] + 1
      queue << [left, y]
    end
  end

  if !maze[y][right]
    if wall(right, y, input)
      maze[y][right] = '#'
    else
      maze[y][right] = maze[y][x] + 1
      queue << [right, y]
    end
  end

  break if maze[destination_y] && maze[destination_y][destination_x]
end

display_maze(maze)
puts maze[destination_y][destination_x]