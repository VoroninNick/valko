class AddGagReferencesToLineItem < ActiveRecord::Migration
  def change
    change_table :line_items do |t|
      t.references :gag
    end
  end
end
