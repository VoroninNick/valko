class CreateJoinTableMetalSheetInformation < ActiveRecord::Migration
  def change
    create_join_table :metal_sheet_details, :information
  end
end
