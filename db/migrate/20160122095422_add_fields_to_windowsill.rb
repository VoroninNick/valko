class AddFieldsToWindowsill < ActiveRecord::Migration
  def change
    change_table :windowsills do |t|
      t.string :decor
      t.string :kapinos
      t.string :type
      t.string :material
      t.string :type_of_surface

    end
  end
end
