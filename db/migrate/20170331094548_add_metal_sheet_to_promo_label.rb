class AddMetalSheetToPromoLabel < ActiveRecord::Migration
  def change
    create_join_table :metal_sheets, :promo_labels
  end
end
