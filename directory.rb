# Refactoring to use Ruby's CSV library instead of File
require 'csv'
# Setup global variables
@students = []
@defaultList = false
@defaultFileName = "students.csv"
@months = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]
def default_students
# A hash of default students which is an option for the user to load
@students = [
  {name: "Dr. Hannibal Lecter",cohort: :November},
  {name: "Darth Vader", cohort: :November},
  {name: "Nurse Ratched", cohort: :November},
  {name: "Michael Corleone", cohort: :November},
  {name: "Alex DeLarge", cohort: :November},
  {name: "The Wicked Witch of the West", cohort: :November},
  {name: "Terminator", cohort: :November},
  {name: "Freddy Krueger", cohort: :November},
  {name: "The Joker", cohort: :November},
  {name: "Joffrey Baratheon", cohort: :November},
  {name: "Norman Bates", cohort: :November}
]
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
    when "1"
      input_students
      puts "Finished inputting students."
    when "2"
      show_students
      puts "Finished showing students."
    when "3"
      save_Students
      puts "Finished saving students."
    when "4"
      load_students_manual
      puts "Finished loading students."
    when "5"
      clear_students
      puts "Finished clearing the current student list."
    when "6"
      exit
    when "7"
      load_default_students
      puts "Finished loading default students."
    when "8"
      print_by_cohort
      puts "Finished showing students by cohort"
    when "9"
      print_by_character_count
      puts "Finished."
    when "10"
      print_by_first_letter
      puts "Finished."
    else
      "I didn't understand that command. Please try again."
  end
end

def load_default_students
  puts "WARNING - This will overwrite all students currently loaded."
  puts "Continue? y/n"
  continue = STDIN.gets.chomp.downcase
  default_students unless continue == "n"
end

def clear_students
  puts "WARNING - This will clear all students currently loaded."
  puts "Continue? y/n"
  continue = STDIN.gets.chomp.downcase
  @students = [] unless continue == "n"
end

def print_menu
  puts "What do you want to do?"
  print_break
  puts "BASIC OPERATIONS"
  print_break
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list"
  puts "4. Load a list"
  puts "5. Clear all currently loaded students"
  puts "6. Exit"
  print_break
  puts "ADVANCED OPERATIONS"
  print_break
  puts "7. Load a default list of students"
  puts "8. Show students by cohort"
  puts "9. Show students whose name is longer than 'X' characters"
  puts "10.Show students whose names starts with 'X'"
end

def show_students
  print_header
  print(@students)
  print_footer
end

def print_input_instrucs
  puts("Please enter the names of the students.")
  puts("To finish, just hit return twice.")
  puts("If no names are entered, I will use the default list.")
end

def input_students
  print_input_instrucs
  # Get the first name
  # Use gsub to substitute a string instead of chomp
  name = STDIN.gets.gsub("\n","")
  # While the name is not empty, repeat this code
  while !name.empty? do
    puts("Please enter #{name}'s cohort.'")
    # Get the cohort from the user.
    cohort = STDIN.gets.gsub("\n","")
    check_valid_month(cohort)
    # Add the student to the array
    add_student(name, cohort)
    puts("Now we have #{@students.count} #{plural_studs}.")
    # Get another name from the user
    puts("Please enter the next name.")
    name = STDIN.gets.gsub("\n","")
  end
  set_default_students
end

def plural_studs
  return "students" unless @students.count < 2
end

def set_default_students
  if @students.count == 0 && @defaultList == true
    @students = default_students
  end
end

def print_header
  print_break
  puts("The students of Villians Academy")
  print_break
end

def print_break
  puts("-------------")
end

def check_valid_month(cohort)
  # Look-up the user input for cohort in the list of allowed symbols (months of the year).
  # Unti it is valid, ask the user to re-enter
  while !@months.include?(cohort.to_sym)
    puts("Couldn't find the \'#{cohort}\' cohort, please check your spelling and case!")
    cohort = STDIN.gets.gsub("\n","")
  end
end

def print(students)
    count = 0
    while count < students.count
      puts("#{count + 1}. #{students[count][:name]} (#{students[count][:cohort]} cohort)")
      count += 1
    end
end

def print_by_first_letter
  puts "Enter a first letter character to search for."
  letter = STDIN.gets.chomp
  while letter.class != String && letter.length > 1
    puts "That is not a valid character. Please try again."
    letter = STDIN.gets.chomp
  end
  @students.each_with_index() do |student, index|
    puts("#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)") if student[:name][0] == letter
  end
end

def print_by_character_count
  puts "Enter a maximum character count."
  count = STDIN.gets.chomp.to_i
  while count == 0
    puts "That is not a valid integer. Please try again."
    count = STDIN.gets.chomp.to_i
  end
  @students.each_with_index() do |student, index|
    puts("#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)") if student[:name].length < count
  end
end

def print_footer
  print_break
  if @students.count == 0
    puts("There are no students in the database :(")
  else
    puts("Overall, we have #{@students.count} great #{plural_studs}.")
  end
  print_break
end

def print_to_center(message)
  puts message.center(50)
end

def print_by_cohort
  @months.each do |cohort|
    students_this_month = Array.new
    @students.each do |student|
      students_this_month.push(student) if student[:cohort] == cohort
    end
    print_break
    puts("#{cohort.to_s.capitalize} (#{students_this_month.size} students)")
    print_break
    students_this_month.count > 0 ? print(students_this_month) : puts("There are no students in the #{cohort.to_s.capitalize} cohort")
  end
end

def check_file_from_user
  puts "Please enter a filename (without the extension)."
  checkName = STDIN.gets.chomp
  while checkName.to_s.empty?
    puts "Sorry that is not a valid filename. Please try again"
    checkName = STDIN.gets.chomp
  end
  checkName  << ".csv"
end

def save_Students()
  saveName = check_file_from_user
  CSV.open(saveName, "w") do |csv|
    # Iterate over the array of students
    @students.each do |student|
      csv << [student[:name], student[:cohort]]
    end
  end
  puts "Student directory saved to #{saveName}."
end

def load_students_manual
  loadName = check_file_from_user if loadName.to_s.empty?
  while
    !File.exists?(loadName)
    puts "File does not exist."
    loadName = check_file_from_user
  end
  puts "Do you want to overwrite the currently loaded student list?"
  puts "y/n"
  continue = STDIN.gets.chomp.downcase
  clear_students unless continue == "n"
  load_operation(loadName)
end

def add_student(name, cohort)
 @students << {name: name, cohort: cohort.to_sym}
end

def load_students_auto
  filename = ARGV.first
  if filename.nil?
    puts "No filename provided as start-up argument. Loading default students file from #{@defaultFileName}"
    load_operation(@defaultFileName)
  else
  end
end

def load_operation(filename)
  if File.exists?(filename)
    CSV.foreach(filename) do |row|
      name = row[0]
      cohort = row[1]
      add_student(name, cohort)
    end
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} dosen't exist."
  end
end

#nothing happens until we call the methods
load_students_auto
interactive_menu
