class AddFieldToWindowsill < ActiveRecord::Migration
  def change
    change_table :windowsills do |t|
      t.text :custom
      t.boolean :with_flap
      t.boolean :without_cap
      t.boolean :on_the_edge
      t.boolean :customised

    end
  end
end
