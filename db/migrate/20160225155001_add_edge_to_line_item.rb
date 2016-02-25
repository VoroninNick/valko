class AddEdgeToLineItem < ActiveRecord::Migration
  def change
    change_table :line_items do |t|
      t.boolean :with_edge
    end
  end
end
