class Company
  attr_accessor :employees, :customers

  def initialize
    @employees = []
    @customers = []
  end

  def add_employee(employee)
    @employees << employee
  end

  def list_employees
    @employees.each do |employee|
      puts "#{employee.name} <#{employee.email}>  Phone: #{employee.phone} Salary: $#{'%.2f' % employee.salary}"
    end
  end
end
