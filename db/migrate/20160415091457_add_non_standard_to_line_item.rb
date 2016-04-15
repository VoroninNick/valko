class AddNonStandardToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :nonstandard, :boolean
  end
end
