# put students into an array
students = [
  {name: "Dr. Hannibal Lecter",cohort: :november},
  {name: "Darth Vader", cohort: :november},
  {name: "Nurse Ratched", cohort: :november},
  {name: "Michael Corleone", cohort: :november},
  {name: "Alex DeLarge", cohort: :november},
  {name: "The Wicked Witch of the West", cohort: :november},
  {name: "Terminator", cohort: :november},
  {name: "Freddy Krueger", cohort: :november},
  {name: "The Joker", cohort: :november},
  {name: "Joffrey Baratheon", cohort: :november},
  {name: "Norman Bates", cohort: :november}
]

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # Create an empty array
  students = []
  # Get the first name
  name = gets.chomp
  # While the name is not empty, repeat this code
  while !name.empty? do
    # Add the student to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    # Get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villians Academy"
  puts "-------------"
end

def print(students)
  students.each_with_index() do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_by_first_letter(students, letter)
  students.each_with_index() do |student, index|
    if student[:name][0] == letter
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    else
    end
  end
end

def print_by_character_count(students, count)
  students.each_with_index() do |student, index|
    if student[:name].length < count
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    else
    end
  end
end

def print_footer(names)
puts "Overall, we have #{names.count} great students"
end
#nothing happens until we call the methods
students = input_students
character_limit = 12
puts "Students whose names are shorter than #{character_limit} characters"
puts "-------------"
print_by_character_count(students, character_limit)
