require 'date'

class Student
  attr_accessor :name, :surname, :dateOfBirth
  @@students = []
  def initialize(name, surname, dateOfBirth)
    @name, @surname, @dateOfBirth = name, surname, dateOfBirth
    if Date.parse(dateOfBirth) >= Date.today then raise ArgumentError , 'Не рожден(а)' end

    unless @@students.any? {|student| student.name == name and student.surname == surname and student.dateOfBirth == dateOfBirth}
      @@students << self
    end
  end


  def calculate_age
    today = Date.today
    birth = Date.parse(dateOfBirth)
    age = today.year - birth.year
    age -= 1 if today < birth.next_year(age)
    age
  end

  def self.add_student(student)
    unless @@students.any? { |s| s.name == student.name && s.surname == student.surname && s.dateOfBirth == student.dateOfBirth }
      @@students << student
    end
  end

  def self.remove_student(student)
    @@students.delete_if {|s| s.name == student.name and s.surname == student.surname and s.dateOfBirth == student.dateOfBirth}
  end

  def self.get_students_by_age(age)
    @@students.select{|student| student.calculate_age == age}
  end

  def self.get_students_by_name(name)
    @@students.select{|student| student.name == name}
  end

  def self.students
    @@students
  end
  def ==(other)
    other.is_a?(Student) &&
      name == other.name &&
      surname == other.surname &&
      dateOfBirth == other.dateOfBirth
    # метод - дабы Minitest считал,
    # что два студента с одинаковым именем, фамилией
    # и датой являются эквивалентными объектами
  end

end

student1 = Student.new('Alex', 'Ivanov', '2005-05-05')
Student.add_student(student1)
puts student1.name
puts 'calculate_age(): ' + student1.calculate_age.to_s
puts 'get_students_by_age(): ' + Student.get_students_by_age(19).to_s
puts 'get_students_by_name():' + Student.get_students_by_name('Alex').to_s

student2 = Student.new('Anton', 'Rybnik', '1993-09-09')
Student.add_student(student2)
puts 'students(): ' + Student.students.to_s

Student.remove_student(student1)
puts 'students(): ' + Student.students.to_s

# student3 = Student.new('Kate', 'Aleksyuk', '2037-06-10')
# Student.add_student(student3)
