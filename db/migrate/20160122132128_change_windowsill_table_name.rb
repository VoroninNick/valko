class ChangeWindowsillTableName < ActiveRecord::Migration
  def change
    rename_column :windowsills, :type, :wind_type
  end
end
