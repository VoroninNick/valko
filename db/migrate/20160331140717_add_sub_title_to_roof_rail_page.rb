class AddSubTitleToRoofRailPage < ActiveRecord::Migration
  def change
    change_table :roof_rail_pages do |t|
      t.string :subtitle

    end
  end
end
