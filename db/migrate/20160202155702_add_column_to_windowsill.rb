class AddColumnToWindowsill < ActiveRecord::Migration
  def change
    add_column :windowsills, :color_type, :string
  end
end
