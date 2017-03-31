class AddStatusToMetalTile < ActiveRecord::Migration
  def change
    change_table :metal_tiles do |t|
      t.boolean :status
    end
  end
end
