class JoinMetalSheetToPromotion < ActiveRecord::Migration
  def change
    create_join_table :metal_sheets, :promotions
  end
end
