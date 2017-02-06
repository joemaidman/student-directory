# A program that reads its own source code (?!) and prints it to the screen.
fileName = $0
puts "The name of the script that is currently running is #{fileName}"
puts "----------"
puts "SOURCE STARTS"
puts "----------"
File.foreach(fileName, "r") do |line|
  print line
end
puts "----------"
puts "SOURCE ENDS"
puts "----------"
