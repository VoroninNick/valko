# t.belongs_to :cart
# t.references :windowsill
# t.integer :quantity
# t.string :class_name
# t.boolean :with_gag
# t.integer :weight
# t.integer :long

# t.references :gag
# t.boolean :nonstandard

# adding for mosquito grid
# t.belongs_to :mosquito_item
# t.belongs_to :mosquito_item_option
# t.string :product_options

class LineItem < ActiveRecord::Base
  belongs_to :windowsill
  belongs_to :gag
  belongs_to :cart
  belongs_to :roof_rail_item
  belongs_to :mosquito_item
  belongs_to :mosquito_item_option

  attr_accessible *attribute_names
  attr_accessible :windowsill, :cart, :gag

  def increase_quantity count
    self.quantity = self.quantity + count.to_i
  end

  def price
    if self.class_name == 'Windowsill'
      o = windowsill.prices.where(key: self.weight).first.value
      # if with_gag? && windowsill.brand.gag
      #   if o
      #     return (o*self.long/1000) + windowsill.brand.gag.price
      #   else
      #     return nil
      #   end
      # elsif with_edge?
      #   if o
      #     return (o*self.long/1000) + windowsill.edge_price
      #   else
      #     return nil
      #   end
      # else
      #   if o
      #     return o
      #   else
      #     return nil
      #   end
      # end
      return o

    elsif self.class_name == 'Gag'
      o = gag.price || 0
      return o

    elsif self.class_name == 'Decking'
      # o = roof_rail_item.rr_details.find_by_title(self.color).price || 0
      # current_el = RoofRailItem.where(slug: roof_rail_item.slug).where(producer: roof_rail_item.producer).where(thickness: roof_rail_item.thickness).where(coating: roof_rail_item.coating).where(protective_lamina: roof_rail_item.protective_lamina)
      # o = current_el.first.rr_details.where(title: color)
      o = self.roof_rail_item.rr_details.find_by_title(self.color).price || 0
      return o
    elsif self.class_name == 'Mosquito'
      o = self.mosquito_item_option.price || 0
    end

  end


  def total_price(long = 1000)
    gag_edge_price = 0

    # if !long.is_a?(Numeric)
    #   raise TypeError, "please provide long <numeric>"
    # end

    if with_gag && windowsill.brand.gag
      gag_edge_price = windowsill.brand.gag.price
    elsif with_edge
      gag_edge_price =  windowsill.edge_price
    end
    gag_edge_price
    current_price = price

    if self.class_name == 'Windowsill'
      ((current_price *(long.to_f/1000))+gag_edge_price)* quantity
    elsif self.class_name == 'Gag'
      current_price * quantity
    elsif self.class_name == 'Decking'
      ((current_price *(long.to_f/1000))*(roof_rail_item.width.to_f/1000))* quantity
    elsif self.class_name == 'Mosquito'
      # real_price = mosquito_item.calculate_one_item(long, weight)
      # real_price * quantity
      18
    end
  end
end
