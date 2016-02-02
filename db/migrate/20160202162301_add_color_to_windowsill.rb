class AddColorToWindowsill < ActiveRecord::Migration
  def change
    add_column :windowsills, :color, :string
  end
end
