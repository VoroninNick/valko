class AddStatusToSealant < ActiveRecord::Migration
  def change
    change_table :sealants do |t|
      t.boolean :status
    end
  end
end
