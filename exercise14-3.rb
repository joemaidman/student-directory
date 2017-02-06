# More refactoring
# Setup global variables
@students = []
@defaultList = false
@defaultFileName = "students.csv"
@months = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]
def default_students
# A hash of default students which is an option for the user to load
@students = [
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
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_Students
    when "4"
      load_students
    when "5"
      load_default_students
    when "9"
      exit
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

def print_menu
  puts "What do you want to do?"
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "5. Load a default list of students"
  puts "9. Exit"
end

def show_students
  print_header
  print
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

def print
    count = 0
    while count < @students.count
      puts("#{count + 1}. #{@students[count][:name]} (#{@students[count][:cohort]} cohort)")
      count += 1
    end
end

def print_by_first_letter(letter)
  @students.each_with_index() do |student, index|
    puts("#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)") if student[:name][0] == letter
  end
end

def print_by_character_count(count)
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

def save_Students()
  # Open the file for writing
  file = File.open("students.csv", "w")
  # Iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    # puts is equivalent to STDOUT.puts
    file.puts csv_line
  end
  file.close
  puts "Student directory saved to students.csv."
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    # Parallel assignment here
    name, cohort = line.chomp.split(',')
    add_student(name, cohort)
  end
  file.close
end

def add_student(name, cohort)
 @students << {name: name, cohort: cohort.to_sym}
end

def try_load_students
  filename = ARGV.first
  if filename.nil?
    puts "No filename provided as start-up argument. Loading default students file from #{@defaultFileName}"
    load_students
  else
    if File.exists?(filename)
      load_students(filename)
      puts "Loaded #{@students.count} from #{filename}"
    else
      puts "Sorry, #{filename} dosen't exist."
      exit
    end
  end
end

#nothing happens until we call the methods
try_load_students
interactive_menu
