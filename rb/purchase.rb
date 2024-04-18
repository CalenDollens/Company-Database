class Purchase
    attr_reader :item, :qty, :cost
  
    def initialize(item, qty, cost)
      @item = item
      @qty = qty
      @cost = cost
    end
  
    def total
      @qty * @cost
    end

    # Convert purchase data to a string for file storage
    def to_file_format
      "#{item}\n#{qty}\n#{cost}"
    end
  end