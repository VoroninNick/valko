class AddColumnRoofRailIdToRrDescription < ActiveRecord::Migration
  def change
    change_table :roof_rail_items do |t|
      t.belongs_to :rr_description
    end
  end
end
