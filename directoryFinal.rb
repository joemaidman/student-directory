# Setup global variables
@students = []
@defaultList = false
@months = [:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december]
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

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "9"
      exit
    else
      "I didn't understand that command. Please try again."
  end
end

def print_menu
  puts "What do you want to do?"
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit"
end

def show_students
  print_header
  print
  print_footer
end

def input_students
  puts("Please enter the names of the students.")
  puts("To finish, just hit return twice.")
  puts("If no names are entered, I will use the default list.")
  # Get the first name
  # Use gsub to substitute a string instead of chomp
  name = gets.gsub("\n","")
  # While the name is not empty, repeat this code
  while !name.empty? do
    puts("Please enter #{name}'s cohort.'")
    # Get the cohort from the user.
    cohort = gets.gsub("\n","")
    # If the string is empty from the users input, set it to nil
    if cohort.empty?
      cohort = nil
      # and default to november with ||= syntax
      cohort ||= :november
    else
      check_valid_month
    end
    # Add the student to the array
    @students << {name: name, cohort: cohort.to_sym}
    # Test if we have more than 1 students and set a variable to hold the last word
    student_plural = "student"
    if @students.count > 1
      student_plural = "students"
    end
    puts("Now we have #{@students.count} #{student_plural}.")
    # Get another name from the user
    puts("Please enter the next name.")
    name = gets.gsub("\n","")
  end
  set_default_students
end

def set_default_students
  # Set students to default if the user has not entered anyone
  # Commented out code that sets the student list to the default if the user enters nobody
  if @students.count == 0 && @defaultList == true
    @students = default_students
  end
end

def print_header
  puts("-------------")
  puts("The students of Villians Academy")
  puts("-------------")
end

def check_valid_month
  # Look-up the user input in the list of allowed symbols (months of the year).
  # Unti it is valid, ask the user to re-enter
  while !@months.include?(cohort.to_sym)
    puts("Couldn't find the \'#{cohort}\' cohort, please check your spelling and case (all lower)!")
    cohort = gets.gsub("\n","")
  end
end

def print
    count = 0
    while count < @students.count
      puts("#{count + 1}. #{@students[count][:name]} (#{@students[count][:cohort]} cohort)")
      count += 1
    end
end

def print_by_first_letter(letter)
  @students.each_with_index() do |student, index|
    if student[:name][0] == letter
      puts("#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)")
    else
    end
  end
end

def print_by_character_count(count)
  @students.each_with_index() do |student, index|
    if student[:name].length < count
      puts("#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)")
    else
    end
  end
end

def print_footer
  if @students.count == 1
    puts("Overall, we have #{@students.count} great student.")
  elsif @students.count > 1
    puts("Overall, we have #{@students.count} great students.")
  else
  puts("There are no students in the database :(")
  end
end
# A method that takes a string input and puts it to the screen, centered 50 characters from the edge
def print_to_center(message)
puts message.center(50)
end

def print_by_cohort
  @months.each do |cohort|
    students_this_month = Array.new
      @students.each do |student|
        if student[:cohort] == cohort
          students_this_month.push(student)
        end
      end
      puts("-------------")
      puts("#{cohort.to_s.capitalize} (#{students_this_month.size} students)")
      puts("-------------")
      if students_this_month.count > 0
        print(students_this_month)
      else
        puts("There are no students in the #{cohort.to_s.capitalize} cohort")
      end
    end
end

#nothing happens until we call the methods
interactive_menu
