class AddStatusToChoicestItem < ActiveRecord::Migration
  def change
    change_table :choicest_items do |t|
      t.boolean :status
    end
  end
end
