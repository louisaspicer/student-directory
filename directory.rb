#create instance variable here to be accessible in any of the methods
@students = []

#start the program with this - loops the menu and process methods until exit
def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def print_menu
  puts "Please select an option:"
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

#the parameter is what will be used for the 'case'
#we want the input from the user so when the method is called, we put gets.chomp
#as the argument. But this means that selection can be set to anything i.e "1"
def process(selection)
  #using the 'case' selection (input) do the following
  #similar to if/case but uses the === operator to compare
  #e.g if you want to see if the case is a String: String === 'str' => true
  case selection
    when "1"
     input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "I don't know what you meant, try again"
  end
end

def show_students
  #print header
  puts "The students of Villains Academy"
  puts "-------------"
  #print_students_list
  index = 0
    while index < @students.count
      puts "#{index + 1}: #{@students[index][:name]} (#{@students[index][:cohort]} cohort)".center(50)
      index += 1
    end
  #print_footer
  if @students.count < 1
    puts "You have not entered any students"
    puts "-------------"
  else
    puts "Overall, we have #{@students.count} great students"
    puts "-------------"
  end

end

def input_students
  puts "Please enter the details of the students"
  puts "To finish, just hit return a few times"
  #create an empty array
  #get the first name
  puts "Name?"
  #another way to delete newline
  name = gets.delete("\n")
  puts "Cohort?"
  cohort = gets.chomp.to_sym
  cohort.empty? || cohort.length < 2 ? cohort = :unknown : cohort
  puts "Hobbies?"
  hobbies = gets.chomp.to_sym
  puts "Country of birth?"
  country = gets.chomp.to_sym

  #while the name is not empty, repeat this code
  #it will be empty if the user hit return for the second time
  while !name.empty? do
    @students << {name: name, hobbies: hobbies, country: country, cohort: cohort}
    if @students.count < 2
      puts "Now we have #{@students.count} student"
    else
      puts "Now we have #{@students.count} students"
    end

    puts "Name?"
    name = gets.chomp
    break if name.empty?
    puts "Cohort?"
    cohort = gets.chomp.to_sym
    cohort.empty? || cohort.length < 2 ? cohort = :unknown : cohort
    puts "Hobbies?"
    hobbies = gets.chomp.to_sym
    puts "Country of birth?"
    country = gets.chomp.to_sym
  end
  #if no students are entered, exit the program
  if @students.count < 1
    exit(0)
  else
  #return the array of students
    @students
  end
end

def save_students
  #open the file for writing and save as 'file' variable to write to.
  #the second argument is what you want to do with the file
  #"w" means to write to the file
  #the function open automatically allows read 'r' access.
  file = File.open("students.csv", "w")
  #iterate over the array of students
  #@students is an array of hashes
  #the .each method takes each hash element (a students profile)
  #and takes the necessary data from the hashes
  #using the hash key accessor, which is a symbol. This collects the string value
  @students.each do |student|
    #for each student we create a new array in order to convert to a String
    #with a comma, using the .join method
    student_data = [student[:name], student[:cohort]]
    #save string as a variable
    csv_line = student_data.join(",")
    #call the method puts on the open file, so it writes to the file not the screen
    #csv_line is the puts' method argument
    #when we call puts() on it's own, Ruby assumes we want to write it to STDOUT
    file.puts csv_line
  end
  #every time you open a file, it needs to be closed
  file.close
end

def load_students
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
    #the split at the comma gives us an array with two elements
    #parallel assignment; assigning two variables at the same time
    #if the assigned value is an array, the first variable will get the first element
    #the second variable will get the second element, and so on.
    name, cohort = line.chomp.split(",")
    #the elements are put into a hash with the keys as symbols then
    #added to the students array.
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

#def print_header
#end

#def print_students
#end

#def print_footer
#end

def print_cohort
  puts "Which cohort would you like to see?"
  cohort = gets.chomp.to_sym

  selected_cohort = @students.select {|student| student[:cohort] == cohort }

  selected_cohort.each_with_index do |student, index|
    puts "#{index + 1}: #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_d
  with_d = @students.select {|student| student[:name][0].downcase.match('d')}

  if with_d.count == 0
    puts "No students starting with letter D"
  else
    puts "Students starting with the letter D:"
  end

  with_d.each_with_index do |student, index|
  puts "#{index + 1}: #{student[:name]} (#{student[:cohort]} cohort)"
  end

end

def print_short
  short = @students.select {|student| student[:name].length < 12}

  if short == 0
    puts "No students with name shorter than 12 characters"
  else
    puts "Students with name shorter than 12 characters:"
  end

  short.each_with_index do |student, index|
    puts "#{index + 1}: #{student[:name]} (#{student[:cohort]} cohort)"
  end
end


interactive_menu

print_d(students)
print_short(students)
print_cohort(students)
