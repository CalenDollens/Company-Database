-- Module with Cusotmer class that returns Customer table
Customer = {}
Customer.__index = Customer

function Customer.new(name, email, phone)
    local self = setmetatable({}, Customer)
    self.name = name
    self.email = email
    self.phone = phone
    self.purchases = {}
    return self
end

return Customer