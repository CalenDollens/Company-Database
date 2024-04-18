-- Module with Employee class that returns employee table
Employee = {}
Employee.__index = Employee

function Employee.new(name, email, phone, salary)
    local self = setmetatable({}, Employee)
    self.name = name
    self.email = email
    self.phone = phone
    self.salary = salary
    return self
end

return Employee