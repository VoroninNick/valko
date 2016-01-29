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

end
