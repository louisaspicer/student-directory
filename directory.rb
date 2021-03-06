
@students = []
require 'csv'

def load_students_default
  @filename = ARGV.first
  @filename = "students.csv" if @filename.nil?

  check_file_exists

end

def check_file_exists
  if @filename == ""
    puts "You have not entered a file."
    interactive_menu
  elsif File.exists?(@filename)
    CSV.foreach(@filename) do |row|
      @name, @cohort, @hobby, @country = row[0], row[1], row[2], row[3]
      add_student_data
      end
    puts "Loaded #{@students.count} from #{@filename}"
  else
    puts "Sorry, #{@filename} doesn't exist."
    interactive_menu
  end
end

def load_file
  puts "Please enter the filename you would like to load from:"
  @filename = STDIN.gets.chomp

  check_file_exists
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "Please select an option:"
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to a file"
  puts "4. Load a list of students from a chosen file"
  puts "9. Exit"
end

def process(selection)
  case selection
    when "1"
     input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_file
    when "9"
      exit
    else
      puts "I don't know what you meant, try again"
  end
end

def request_data
  puts "What is the student's name?"
  @name = STDIN.gets.chomp
  if @name == ""
    puts "No student was entered."
    interactive_menu
  else
  puts "Which cohort are they in?"
  @cohort = STDIN.gets.chomp
  @cohort.empty? || @cohort.length < 2 ? @cohort = :unknown : @cohort
  puts "What is their favourite hobby?"
  @hobby = STDIN.gets.chomp
  puts "What is their country of birth?"
  @country = STDIN.gets.chomp
  puts "You have now added #{@name}, in the #{@cohort} cohort, with the hobby #{@hobby}, and who was born in #{@country}."
  end
end

def add_student_data
  @students << {name: @name, cohort: @cohort.to_sym, hobby: @hobby.to_sym, country: @country.to_sym}
end

def show_students
  puts "The students of Villains Academy"
  puts "-" * 15

  index = 0
    while index < @students.count
      puts "#{index + 1}: #{@students[index][:name]} (#{@students[index][:cohort]} cohort)".center(50)
      index += 1
    end

  if @students.count < 1
    puts "You have not entered any students"
    puts "-" * 15
  else
    puts "Overall, we have #{@students.count} great students"
    puts "-" * 15
  end
end

def input_students
  puts "Please enter the details of the students"
  puts "To finish, just hit return a few times"

  request_data

  while !@name.empty? do
    add_student_data

      if @students.count < 2
        puts "Now we have #{@students.count} student"
      else
        puts "Now we have #{@students.count} students"
      end

    request_data
  end

  if @name.empty?
    puts "You have not added any students"
  end

end

def save_students
  puts "Please enter the filename you would like to save the students to:"
  @filename = STDIN.gets.chomp
  if @filename == ""
    puts "You have not entered a file."
    interactive_menu
  else
    CSV.open(@filename, "wb") do |csv|
      @students.each do |student|
      student_data = [student[:name], student[:cohort], student[:hobby], student[:country]]
      csv << student_data
      end
      end
    puts "You have saved students to your #{@filename} file and the file has been closed."
  end
end


#def print_cohort
#  puts "Which cohort would you like to see?"
#  cohort = gets.chomp.to_sym
#
#  selected_cohort = @students.select {|student| student[:cohort] == cohort }
#
#  selected_cohort.each_with_index do |student, index|
#    puts "#{index + 1}: #{student[:name]} (#{student[:cohort]} cohort)"
#  end
#end
#
#def print_d
#  with_d = @students.select {|student| student[:name][0].downcase.match('d')}
#
#  if with_d.count == 0
#    puts "No students starting with letter D"
#  else
#    puts "Students starting with the letter D:"
#  end
#
#  with_d.each_with_index do |student, index|
#  puts "#{index + 1}: #{student[:name]} (#{student[:cohort]} cohort)"
#  end
#
#end
#
#def print_short
#  short = @students.select {|student| student[:name].length < 12}
#
#  if short == 0
#    puts "No students with name shorter than 12 characters"
#  else
#    puts "Students with name shorter than 12 characters:"
#  end
#
#  short.each_with_index do |student, index|
#    puts "#{index + 1}: #{student[:name]} (#{student[:cohort]} cohort)"
#  end
#end

load_students_default
interactive_menu
