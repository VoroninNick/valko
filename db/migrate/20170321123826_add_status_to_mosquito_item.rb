class AddStatusToMosquitoItem < ActiveRecord::Migration
  def change
    change_table :mosquito_items do |t|
      t.boolean :status
    end
  end
end
