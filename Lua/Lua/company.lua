-- -- Module with Company class that returns Company table
Company = {}
Company.__index = Company

function Company.new()
    local self = setmetatable({}, Company)
    self.employees = {}
    self.customers = {}
    return self
end

function Company:add_employee(employee)
    table.insert(self.employees, employee)
end

function Company:list_employees()
    for _, employee in ipairs(self.employees) do
        print(employee.name .. " <" .. employee.email .. ">  Phone: " .. employee.phone .. " Salary: $" .. string.format("%.2f", employee.salary))
    end
end

return Company