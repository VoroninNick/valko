class AddPageToRoofRailPage < ActiveRecord::Migration
  def change
    change_table :roof_rail_pages do |t|
      t.string :page_name

    end
  end
end
