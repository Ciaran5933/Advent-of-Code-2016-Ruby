input = IO.readlines('input.txt')[0].to_i

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

visited = 1

while queue.length > 0
  x, y = queue.shift

  break if maze[y][x] >= 50

  right = x + 1
  left = x - 1
  up = y - 1
  down = y + 1

  maze << [] if !maze[down]

  # Could abstract this

  if !maze[down][x]
    if wall(x, down, input)
      maze[down][x] = '#'
    else
      maze[down][x] = maze[y][x] + 1
      queue << [x, down]
      visited += 1
    end
  end

  if up >= 0 && !maze[up][x]
    if wall(x, up, input)
      maze[up][x] = '#'
    else
      maze[up][x] = maze[y][x] + 1
      queue << [x, up]
      visited += 1
    end
  end

  if left >= 0 && !maze[y][left]
    if wall(left, y, input)
      maze[y][left] = '#'
    else
      maze[y][left] = maze[y][x] + 1
      queue << [left, y]
      visited += 1
    end
  end

  if !maze[y][right]
    if wall(right, y, input)
      maze[y][right] = '#'
    else
      maze[y][right] = maze[y][x] + 1
      queue << [right, y]
      visited += 1
    end
  end

end

display_maze(maze)
puts visited