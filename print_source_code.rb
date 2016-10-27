# Method to print file's own source code

File.open(__FILE__).each do |line|
  puts line
end
