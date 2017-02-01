# put students into an array in case the user does not enter anything.
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

def input_students(months)
  print_to_center("Please enter the names of the students.")
  print_to_center("To finish, just hit return twice.")
  print_to_center("If no names are entered, I will use the default list.")
  # Create an empty array
  students = []
  # Get the first name
  name = gets.chomp
  # While the name is not empty, repeat this code
  while !name.empty? do
    print_to_center("Please enter #{name}'s cohort.'")
    # Get the cohort from the user.
    cohort = gets.chomp
    # If the string is empty from the users input, set it to nil
    if cohort.empty?
      cohort = nil
      # and default to november with ||= syntax
      cohort ||= :november
    else

      # Look-up the user input in the list of allowed symbols (months of the year).
      # Unti it is valid, ask the user to re-enter
      while !months.include?(cohort.to_sym)
        print_to_center("Couldn't find the \'#{cohort}\' cohort, please check your spelling and case (all lower)!")
        cohort = gets.chomp
      end

    end
    # Add the student to the array
    students << {name: name, cohort: cohort.to_sym}
    # Test if we have more than 1 students and set a variable to hold the last word
    student_plural = "student"
    if students.count > 1
    student_plural = "students"
    end
    print_to_center("Now we have #{students.count} #{student_plural}.")
    # Get another name from the user
    print_to_center("Please enter the next name.")
    name = gets.chomp
  end
  # Set students to default if the user has not entered anyone
  if students.count == 0
    students = default_students
  end
  # return the array of students
  students
end

def print_header
  print_to_center("-------------")
  print_to_center("-------------")
  print_to_center("The students of Villians Academy")
  print_to_center("-------------")
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
# A method that takes a string input and puts it to the screen, centered 50 characters from the edge
def print_to_center(message)
puts message.center(50)
end

def print_by_cohort(students, months)
  months.each do |cohort|
    students_this_month = Array.new
    students.each do |student|
      if student[:cohort] == cohort
        students_this_month.push(student)
      end
    end
    print_to_center("-------------")
    print_to_center("#{cohort.to_s.capitalize} (#{students_this_month.size} students)")
    print_to_center("-------------")
    if students_this_month.count > 0
      print(students_this_month)
    else
      print_to_center("There are no students in the #{cohort.to_s.capitalize} cohort")
    end
  end
end

#nothing happens until we call the methods
months = [:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december]
students = input_students(months)
print_header
print(students)
print_footer(students)
print_to_center("-------------")
print_to_center("-------------")
print_to_center("Students by cohort")
print_to_center("-------------")
print_by_cohort(students, months)
