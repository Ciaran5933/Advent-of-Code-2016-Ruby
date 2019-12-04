require 'fileutils'

year = ARGV[0]
language = ARGV[1]

(1..31).each do |day|
  day_folder = "#{year}/#{language}/day#{day}"
  FileUtils.mkdir_p day_folder

  files_to_create = ["input.txt", "part1.rb", "part2.rb", "README"]

  FileUtils.touch files_to_create.map { |file| "#{day_folder}/#{file}"}
end