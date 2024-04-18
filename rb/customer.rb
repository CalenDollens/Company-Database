class Customer
  attr_accessor :name, :email, :phone, :purchases

  def initialize(name, email, phone)
    @name = name
    @email = email
    @phone = phone
    @purchases = []
  end
end

class Purchase
  attr_accessor :item, :quantity, :cost

  def initialize(item, quantity, cost)
    @item = item
    @quantity = quantity
    @cost = cost
  end
end
