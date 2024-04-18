-- Module with purchase class that returns a purchase table
Purchase = {}
Purchase.__index = Purchase

function Purchase.new(item, quantity, cost)
    local self = setmetatable({}, Purchase)
    self.item = item
    self.quantity = quantity
    self.cost = cost
    return self
end

return Purchase