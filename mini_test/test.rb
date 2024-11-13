require 'minitest/autorun'
require_relative '../ht1'

class StudentTest < Minitest::Test
  def setup
    @student1 = Student.new('Alex', 'Ivanov', '2005-05-05')
    @student2 = Student.new('Anton', 'Rybnik', '1993-09-09')
  end

  def test_initialize
    assert_equal 'Alex', @student1.name
    assert_equal 'Ivanov', @student1.surname
    assert_equal '2005-05-05', @student1.dateOfBirth
  end

  def test_calculate_age
    assert_equal 19, @student1.calculate_age
  end

  def test_add_student
    Student.add_student(@student1)
    assert_includes Student.students, @student1
  end

  def test_remove_student
    Student.add_student(@student2)
    Student.remove_student(@student2)
    refute_includes Student.students, @student2
  end

  def test_get_students_by_age
    Student.add_student(@student1)
    students_by_age = Student.get_students_by_age(19)
    assert_includes students_by_age, @student1
  end

  def test_get_students_by_name
    Student.add_student(@student1)
    students_by_name = Student.get_students_by_name('Alex')
    assert_includes students_by_name, @student1
  end
end
