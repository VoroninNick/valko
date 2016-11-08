class AddChoicestItemDetailToLineItem < ActiveRecord::Migration
  def change
    change_table :line_items do |t|
      t.belongs_to :choicest_item_detail
    end
  end
end
