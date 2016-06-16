class AddFieldsToLineItems < ActiveRecord::Migration
  def change
    change_table :line_items do |t|
      t.belongs_to :mosquito_item
      t.belongs_to :mosquito_item_option
      t.string :product_options
    end
  end
end
