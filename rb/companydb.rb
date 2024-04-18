require_relative 'company'
require_relative 'employee'
require_relative 'customer'

class CompanyDB
  def initialize(company_name)
    @company = Company.new
    @company_name = company_name
    load_data
  end
  
  #method that checkes if file is present, if so it loads company data, if not it creates new file
  def load_data
    filename = "#{@company_name.downcase}.dat"
    if File.exist?(filename)
      File.open(filename, 'r') do |file|
        num_employees = file.readline.to_i
        num_employees.times do
          name = file.readline.chomp
          email = file.readline.chomp
          phone = file.readline.chomp
          salary = file.readline.chomp.to_f
          employee = Employee.new(name, email, phone, salary)
          @company.add_employee(employee)
        end
  
        num_customers = file.readline.to_i
        num_customers.times do
          customer_name = file.readline.chomp
          customer_email = file.readline.chomp
          customer_phone = file.readline.chomp
          num_purchases = file.readline.to_i
          customer = Customer.new(customer_name, customer_email, customer_phone)
  
          num_purchases.times do
            item = file.readline.chomp
            quantity = file.readline.to_i
            cost = file.readline.to_f
            purchase = Purchase.new(item, quantity, cost)
            customer.purchases << purchase
          end
  
          @company.customers << customer
        end
      end
    else
      # If the file doesn't exist, create a new file with the company name
      File.open(filename, 'w') {}
    end
  end

  # method to save company data in the proper format to a respective .dat file 
  def save_data
    filename = "#{@company_name.downcase}.dat"
    File.open(filename, 'w') do |file|
      file.puts(@company.employees.size)
      @company.employees.each do |employee|
        file.puts(employee.name)
        file.puts(employee.email)
        file.puts(employee.phone)
        file.puts(employee.salary)
      end
  
      file.puts(@company.customers.size)
      @company.customers.each do |customer|
        file.puts(customer.name)
        file.puts(customer.email)
        file.puts(customer.phone)
        file.puts(customer.purchases.size)
        customer.purchases.each do |purchase|
          file.puts(purchase.item)
          file.puts(purchase.quantity)
          file.puts(purchase.cost)
        end
      end
    end
  end

  def list_employees
    @company.list_employees
  end

  # Method handles the main menu of the program
  def main_menu
    loop do
      puts "    MAIN MENU"
      puts "1.) Employees"
      puts "2.) Sales"
      puts "3.) Quit"
      print "\nChoice? "
      choice = gets.chomp.to_i

      case choice
      when 1
        employees_menu
      when 2
        sales_menu
      when 3
        save_data
        exit
      else
        puts "Invalid choice. Please try again."
      end
    end
  end

  #Method handles the Employees menu (1)
  def employees_menu
    loop do
      # List employees to match sample
      @company.list_employees

      print "(A)dd Employee or (M)ain Menu? "
      choice = gets.chomp.upcase

      case choice
      when 'A'
        add_employee
      when 'M'
        break
      else
        puts "Invalid choice. Please try again."
      end
    end
  end

  #add employee to company
  def add_employee
    print "Name: "
    name = gets.chomp
    print "Email: "
    email = gets.chomp
    print "Phone: "
    phone = gets.chomp
    print "Salary: "
    salary = gets.chomp.to_f

    employee = Employee.new(name, email, phone, salary)
    @company.add_employee(employee)  # Add the employee to the company
    #puts "#{employee.name} <#{employee.email}>  Phone: #{employee.phone} Salary: $#{'%.2f' % employee.salary}" #debugging
  end

  # Method hanldes the Sales menu (2)
  def sales_menu
    loop do
      print "(A)dd Customer, Enter a (S)ale, (V)iew Customer, or (M)ain Menu? "
      choice = gets.chomp.upcase

      case choice
      when 'A'
        add_customer
      when 'S'
        enter_sale
      when 'V'
        view_customer
      when 'M'
        break
      else
        puts "Invalid choice. Please try again."
      end
    end
  end

  # method handles adds customer choice
  def add_customer
    print "Name: "
    name = gets.chomp
    print "Email: "
    email = gets.chomp
    print "Phone: "
    phone = gets.chomp

    customer = Customer.new(name, email, phone)
    @company.customers << customer
  end

  #Method handles the sale choice
  def enter_sale
    if @company.customers.empty?
      puts "Error: No Customers." #promtps an error message if customers is empty
      return
    end

    puts "Customers:"
    @company.customers.each_with_index do |customer, index|
      puts "#{index + 1}.) #{customer.name}"
    end

    print "Choice? "
    customer_choice = gets.chomp.to_i - 1

    # Adds purchase to selected customer 
    if customer_choice >= 0 && customer_choice < @company.customers.length
      customer = @company.customers[customer_choice]

      print "Item: "
      item = gets.chomp
      print "Quantity: "
      quantity = gets.chomp.to_i
      print "Cost: "
      cost = gets.chomp.to_f

      purchase = Purchase.new(item, quantity, cost)
      customer.purchases << purchase
    else
      puts "Invalid choice. Sale not entered."
    end
  end

  # Handles view choice
  def view_customer
    if @company.customers.empty?
      puts "Error: No Customers."
      return
    end

    puts "Customers:"
    @company.customers.each_with_index do |customer, index|
      puts "#{index + 1}.) #{customer.name}"
    end

    print "Choice? "
    customer_choice = gets.chomp.to_i - 1

    if customer_choice >= 0 && customer_choice < @company.customers.length
      customer = @company.customers[customer_choice]

      # Prints Purchase history of selected customer 
      puts "#{customer.name} <#{customer.email}>  Phone: #{customer.phone}\n\nOrder History"
      puts "Item                   Price  Quantity   Total"
      customer.purchases.each do |purchase|
        total = purchase.quantity * purchase.cost
        puts "#{purchase.item.ljust(22)}#{purchase.cost.to_s.ljust(7)}#{purchase.quantity.to_s.ljust(10)}#{total}"
      end
    else
      puts "Invalid choice. Cannot view customer."
    end
  end
end

# Main program
print "Company Name: "
company_name = gets.chomp
company_db = CompanyDB.new(company_name)
company_db.main_menu
