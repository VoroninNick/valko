class AddStatusToMembrane < ActiveRecord::Migration
  def change
    change_table :membranes do |t|
      t.boolean :status
    end
  end
end
