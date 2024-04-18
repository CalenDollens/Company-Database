-- companydb Class that is entry point of program
-- Contains program menus and file handling

-- Import statements for classes
local Employee = require("employee")
local Customer = require("customer")
local Purchase = require("purchase")
local Company = require("company")

CompanyDB = {}
CompanyDB.__index = CompanyDB

function CompanyDB.new(company_name)
    local self = setmetatable({}, CompanyDB)
    self.company = Company.new()
    self.company_name = company_name
    self:load_data()
    return self
end

-- Loads employees, customers, and sales based on file formatting
function CompanyDB:load_data()
    local filename = string.lower(self.company_name) .. ".dat"
    local file = io.open(filename, "r")
    if file then
        local content = file:read("*a")
        file:close()

        local lines = {}
        for line in content:gmatch("[^\r\n]+") do
            table.insert(lines, line)
        end

        local numEmployees = tonumber(lines[1])
        local currentLine = 2
        for i = 1, numEmployees do
            local name = lines[currentLine]
            local email = lines[currentLine + 1]
            local phone = lines[currentLine + 2]
            local salary = tonumber(lines[currentLine + 3])
            local employee = Employee.new(name, email, phone, salary)
            self.company:add_employee(employee)
            currentLine = currentLine + 4
        end

        local numCustomers = tonumber(lines[currentLine])
        currentLine = currentLine + 1
        for i = 1, numCustomers do
            local customerName = lines[currentLine]
            local customerEmail = lines[currentLine + 1]
            local customerPhone = lines[currentLine + 2]
            local numPurchases = tonumber(lines[currentLine + 3])
            local customer = Customer.new(customerName, customerEmail, customerPhone)
            currentLine = currentLine + 4

            for j = 1, numPurchases do
                local item = lines[currentLine]
                local quantity = tonumber(lines[currentLine + 1])
                local cost = tonumber(lines[currentLine + 2])
                local purchase = Purchase.new(item, quantity, cost)
                customer.purchases[#customer.purchases + 1] = purchase
                currentLine = currentLine + 3
            end

            self.company.customers[#self.company.customers + 1] = customer
        end

        print("Data loaded successfully.")
    else
        print("Error: Unable to load data. Creating a new company database.")
        -- Create a new file if it doesn't exist
        local newFile = io.open(filename, "w")
        newFile:close()
    end
end

function CompanyDB:save_data()
    local filename = string.lower(self.company_name) .. ".dat"
    local file = io.open(filename, "w")
    if file then
        -- Write employees data
        file:write(#self.company.employees .. "\n")
        for _, employee in ipairs(self.company.employees) do
            file:write(employee.name .. "\n")
            file:write(employee.email .. "\n")
            file:write(employee.phone .. "\n")
            file:write(employee.salary .. "\n")
        end

        -- Write customers data
        file:write(#self.company.customers .. "\n")
        for _, customer in ipairs(self.company.customers) do
            file:write(customer.name .. "\n")
            file:write(customer.email .. "\n")
            file:write(customer.phone .. "\n")
            file:write(#customer.purchases .. "\n")
            for _, purchase in ipairs(customer.purchases) do
                file:write(purchase.item .. "\n")
                file:write(purchase.quantity .. "\n")
                file:write(purchase.cost .. "\n")
            end
        end

        file:close()
        print("Data saved successfully.")
    else
        print("Error: Unable to save data.")
    end
end

function CompanyDB:list_employees()
    self.company:list_employees()
end

function CompanyDB:employees_menu()
    while true do
        -- List employees
        print("Employees:")
        self.company:list_employees()

        io.write("(A)dd Employee or (M)ain Menu? ")
        local choice = io.read():upper()

        if choice == "A" then
            self:add_employee()
        elseif choice == "M" then
            break
        else
            print("Invalid choice. Please try again.")
        end
    end
end

function CompanyDB:add_employee()
    io.write("Enter employee details:\nName: ")
    local name = io.read()
    io.write("Email: ")
    local email = io.read()
    io.write("Phone: ")
    local phone = io.read()
    io.write("Salary: ")
    local salary = tonumber(io.read())

    local employee = Employee.new(name, email, phone, salary)
    self.company:add_employee(employee)
    print("Employee added successfully.")
end

function CompanyDB:sales_menu()
    while true do
        io.write("(A)dd Customer, Enter a (S)ale, (V)iew Customer, or (M)ain Menu? ")
        local choice = io.read():upper()

        if choice == "A" then
            self:add_customer()
        elseif choice == "S" then
            self:enter_sale()
        elseif choice == "V" then
            self:view_customer()
        elseif choice == "M" then
            break
        else
            print("Invalid choice. Please try again.")
        end
    end
end

function CompanyDB:add_customer()
    io.write("Enter customer details:\nName: ")
    local name = io.read()
    io.write("Email: ")
    local email = io.read()
    io.write("Phone: ")
    local phone = io.read()

    local customer = Customer.new(name, email, phone)
    self.company.customers[#self.company.customers + 1] = customer
    print("Customer added successfully.")
end

function CompanyDB:enter_sale()
    if #self.company.customers == 0 then
        print("Error: No Customers.")
        return
    end

    print("Customers:")
    for i, customer in ipairs(self.company.customers) do
        print(i .. ".) " .. customer.name)
    end

    io.write("Enter customer number: ")
    local customer_choice = tonumber(io.read())
    if customer_choice and customer_choice >= 1 and customer_choice <= #self.company.customers then
        local customer = self.company.customers[customer_choice]
        io.write("Item: ")
        local item = io.read()
        io.write("Quantity: ")
        local quantity = tonumber(io.read())
        io.write("Cost: ")
        local cost = tonumber(io.read())

        local purchase = Purchase.new(item, quantity, cost)
        customer.purchases[#customer.purchases + 1] = purchase
        print("Sale entered successfully.")
    else
        print("Invalid choice. Sale not entered.")
    end
end

function CompanyDB:view_customer()
    if #self.company.customers == 0 then
        print("Error: No Customers.")
        return
    end

    print("Customers:")
    for i, customer in ipairs(self.company.customers) do
        print(i .. ".) " .. customer.name)
    end

    io.write("Enter customer number: ")
    local customer_choice = tonumber(io.read())
    if customer_choice and customer_choice >= 1 and customer_choice <= #self.company.customers then
        local customer = self.company.customers[customer_choice]
        print(customer.name .. " <" .. customer.email .. ">  Phone: " .. customer.phone .. "\n\nOrder History")
        print("Item                   Price   Quantity   Total")

        -- handles padding in sales view to neatly display price/qty/total
        for _, purchase in ipairs(customer.purchases) do 
            local itemName = purchase.item .. string.rep(" ", 23 - #purchase.item) 
            local price = string.format("%.2f", purchase.cost) .. string.rep(" ", 9 - #tostring(purchase.cost))
            local quantity = tostring(purchase.quantity) .. string.rep(" ", 11 - #tostring(purchase.quantity))
            local total = string.format("%.2f", purchase.quantity * purchase.cost)
            print(itemName .. price .. quantity .. total)
        end
    else
        print("Invalid choice. Cannot view customer.")
    end
end

function CompanyDB:main_menu()
    while true do
        print("    MAIN MENU")
        print("1.) Employees")
        print("2.) Sales")
        print("3.) Quit")
        io.write("Choice? ")
        local choice = tonumber(io.read())

        if choice == 1 then
            self:employees_menu()
        elseif choice == 2 then
            self:sales_menu()
        elseif choice == 3 then
            self:save_data()
            break
        else
            print("Invalid choice. Please try again.")
        end
    end
end

-- Initialize the program
io.write("Company Name: ")
local company_name = io.read()
local company_db = CompanyDB.new(company_name)
company_db:main_menu()
