class CreateTableWindowsillsPromoLabels < ActiveRecord::Migration
  def change
    create_table :table_windowsills_promo_labels do |t|
      t.belongs_to :windowsill
      t.belongs_to :promo_label
    end
  end
end
