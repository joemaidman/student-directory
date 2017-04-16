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
  print_to_center("Please enter the names of the students.")
  print_to_center("To finish, just hit return twice.")
  print_to_center("If no names are entered, I will use the default list.")
  # Create an empty array
  students = []
  # Get the first name
  name = gets.chomp
  # While the name is not empty, repeat this code
  while !name.empty? do
    # Add the student to the array
    students << {name: name, cohort: :november}
    print_to_center("Now we have #{students.count} students")
    # Get another name from the user
    name = gets.chomp
  end
  # return the array of students

  if students.count == 0
    students = default_students
  end
  students
end

def print_header
  print_to_center("The students of Villians Academy")
  print_to_center("-------------")
end

def print(students)
  count = 0
  while count < students.count
    print_to_center("#{count + 1}. #{students[count][:name]} (#{students[count][:cohort]} cohort)")
    count += 1
  end
end

def print_by_first_letter(students, letter)
  students.each_with_index() do |student, index|
    if student[:name][0] == letter
    print_to_center("#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)")
    else
    end
  end
end

def print_by_character_count(students, count)
  students.each_with_index() do |student, index|
    if student[:name].length < count
    print_to_center("#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)")
    else
    end
  end
end

def print_footer(names)
print_to_center("Overall, we have #{names.count} great students")
end

def print_to_center(message)
puts message.center(50)
end

#nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
