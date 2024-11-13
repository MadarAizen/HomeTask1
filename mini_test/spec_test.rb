require 'rspec'
require 'date'
require_relative '../ht1'

RSpec.describe Student do
  let(:student1) { Student.new('Alex', 'Ivanov', '2005-05-05') }
  let(:student2) { Student.new('Anton', 'Rybnik', '1993-09-09') }

  before do
    Student.add_student(student1)
    Student.add_student(student2)
  end

  after do
    Student.remove_student(student1)
    Student.remove_student(student2)
  end

  describe '#initialize' do
    it 'raises an error if date of birth is in the future' do
      expect { Student.new('Kate', 'Aleksyuk', '2037-06-10') }.to raise_error(ArgumentError, 'Не рожден(а)')
    end
  end

  describe '#calculate_age' do
    it 'correctly calculates the age of the student' do
      expect(student1.calculate_age).to eq(19)
      expect(student2.calculate_age).to eq(Date.today.year - 1993)
    end
  end

  describe '.add_student' do
    it 'adds a new student to the students list' do
      expect(Student.students).to include(student1, student2)
    end

    it 'does not add duplicate students to the list' do
      expect { Student.add_student(student1) }.not_to change { Student.students.size }
    end
  end

  describe '.remove_student' do
    it 'removes a student from the students list' do
      Student.remove_student(student1)
      expect(Student.students).not_to include(student1)
    end
  end

  describe '.get_students_by_age' do
    it 'returns students of a specific age' do
      expect(Student.get_students_by_age(19)).to include(student1)
    end
  end

  describe '.get_students_by_name' do
    it 'returns students with a specific name' do
      expect(Student.get_students_by_name('Alex')).to include(student1)
    end
  end
end
