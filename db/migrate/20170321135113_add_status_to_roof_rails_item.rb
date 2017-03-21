class AddStatusToRoofRailsItem < ActiveRecord::Migration
  def change
    change_table :rr_descriptions do |t|
      t.boolean :status
    end
  end
end
