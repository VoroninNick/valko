# t.belongs_to :cart
# t.references :windowsill
# t.integer :quantity
# t.string :type
# t.boolean :with_gag
# t.integer :weight
# t.integer :long
class LineItem < ActiveRecord::Base
  belongs_to :windowsill
  belongs_to :cart

end
