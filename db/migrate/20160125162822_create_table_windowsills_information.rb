class CreateTableWindowsillsInformation < ActiveRecord::Migration
  def change
    create_table :table_windowsills_informations do |t|
      t.belongs_to :windowsill
      t.belongs_to :information
    end
  end
end
