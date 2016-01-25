class CreateTableWindowsillsPromotions < ActiveRecord::Migration
  def change
    create_table :table_windowsills_promotions do |t|
      t.belongs_to :windowsill
      t.belongs_to :promotion
    end
  end
end
