class AddStatusToMetalSheet < ActiveRecord::Migration
  def change
    change_table :metal_sheets do |t|
      t.boolean :status
    end
  end
end
