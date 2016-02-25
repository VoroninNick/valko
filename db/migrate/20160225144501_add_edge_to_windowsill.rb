class AddEdgeToWindowsill < ActiveRecord::Migration
  def change
    change_table :windowsills do |t|
      t.integer :edge_price
    end
  end
end
