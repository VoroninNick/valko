# t.belongs_to :cart
# t.references :windowsill
# t.integer :quantity
# t.string :class_name
# t.boolean :with_gag
# t.integer :weight
# t.integer :long

# t.references :gag
class LineItem < ActiveRecord::Base
  belongs_to :windowsill
  belongs_to :gag
  belongs_to :cart
  belongs_to :roof_rail_item

  attr_accessible *attribute_names
  attr_accessible :windowsill, :cart, :gag

  def increase_quantity count
    self.quantity = self.quantity + count.to_i
  end

  def price
    if self.class_name == 'Windowsill'
      o = windowsill.prices.where(key: self.weight).first.value
      if with_gag? && windowsill.brand.gag
        if o
          return (o*self.long/1000) + windowsill.brand.gag.price
        else
          return nil
        end
      elsif with_edge?
        if o
          return (o*self.long/1000) + windowsill.edge_price
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

    elsif self.class_name == 'Gag'
      o = gag.price || 0
      return o

    elsif self.class_name == 'Decking'
      o = roof_rail_item.rr_details.find_by_title(self.color).price || 0
      return o
    end

  end
  def total_price(long = 1000)
    current_price = price
    (current_price *(long.to_f/1000))* quantity
  end
end
