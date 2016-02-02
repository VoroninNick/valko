# t.belongs_to :cart
# t.references :windowsill
# t.integer :quantity
# t.string :class_name
# t.boolean :with_gag
# t.integer :weight
# t.integer :long
class LineItem < ActiveRecord::Base
  belongs_to :windowsill
  belongs_to :cart
  attr_accessible *attribute_names
  attr_accessible :windowsill, :cart

  def increase_quantity count
    self.quantity = self.quantity + count.to_i
  end

  def price
    o = windowsill.prices.where(key: self.weight).first.value
    if with_gag? && windowsill.brand.gag
      if o
        return (o*self.long/1000) + windowsill.brand.gag.price
      else
        return nil
      end
    else
      if o
        return o
      else
        return nil
      end
    end
  end
  def total_price
    price * quantity
  end
end