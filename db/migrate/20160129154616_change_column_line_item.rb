class ChangeColumnLineItem < ActiveRecord::Migration
  def change
    rename_column :line_items, :type, :class_name
  end
end
