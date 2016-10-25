
def input_students
  puts "Please enter the details of the students"
  puts "To finish, just hit return twice"
  #create an empty array
  students = []
  #get the first name
  puts "Name?"
  name = gets.chomp
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
    students << {name: name, hobbies: hobbies, country: country, cohort: cohort}
    puts "Now we have #{students.count} students"

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
  #return the array of students
  students
end


def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)

index = 0

  while index < students.count
    puts "#{index + 1}: #{students[index][:name]} (#{students[index][:cohort]} cohort)".center(50)
    index += 1
  end
end

def print_cohort(students)
  puts "Which cohort would you like to see?"
  cohort = gets.chomp.to_sym

  selected_cohort = students.select {|student| student[:cohort] == cohort }

  selected_cohort.each_with_index do |student, index|
    puts "#{index + 1}: #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_d(students)
  with_d = students.select {|student| student[:name][0].downcase.match('d')}

  if with_d.count == 0
    puts "No students starting with letter D"
  else
    puts "Students starting with the letter D:"
  end

  with_d.each_with_index do |student, index|
  puts "#{index + 1}: #{student[:name]} (#{student[:cohort]} cohort)"
  end

end

def print_short(students)
  short = students.select {|student| student[:name].length < 12}

  if short == 0
    puts "No students with name shorter than 12 characters"
  else
    puts "Students with name shorter than 12 characters:"
  end

  short.each_with_index do |student, index|
    puts "#{index + 1}: #{student[:name]} (#{student[:cohort]} cohort)"
  end
end


def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

students = input_students
print_header
print(students)
print_footer(students)

print_d(students)
print_short(students)
print_cohort(students)
