# put students into an array
def default_students

students = [
  {name: "Dr. Hannibal Lecter",cohort: :november,  hobby: :sport, weight: 87, age: 64},
  {name: "Darth Vader", cohort: :november,  hobby: :reading, weight: 87, age: 53},
  {name: "Nurse Ratched", cohort: :november,  hobby: :music, weight: 100, age: 42},
  {name: "Michael Corleone", cohort: :november,  hobby: :coding, weight: 68, age: 24},
  {name: "Alex DeLarge", cohort: :november, hobby: :coding, weight: 130, age: 28},
  {name: "The Wicked Witch of the West", cohort: :november ,hobby: :gaming, weight: 120, age: 43},
  {name: "Terminator", cohort: :november, hobby: :music, weight: 72, age: 34},
  {name: "Freddy Krueger", cohort: :november, hobby: :reading, weight: 55, age: 18},
  {name: "The Joker", cohort: :november, hobby: :sport, weight: 30, age: 45},
  {name: "Joffrey Baratheon", cohort: :november, hobby: :music, weight: 70, age: 30},
  {name: "Norman Bates", cohort: :november, hobby: :music, weight: 80, age: 25}
]
end

def input_students
  puts "Please enter the names of the students."
  puts "To finish, just hit return twice."
  puts "If no names are entered, I will use the default list."
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

  if students.count == 0
    students = default_students
  end
return students
end

def print_header
  puts "The students of Villians Academy"
  puts "-------------"
end

def print(students)
  count = 0
  while count < students.count
    puts "#{count + 1}. #{students[count][:name]} (#{students[count][:cohort]} cohort)"
    count += 1
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
print_header
print(students)
print_footer(students)
