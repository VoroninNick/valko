class MosquitoItemsPromoLabels < ActiveRecord::Migration
  def change
    create_join_table :mosquito_items, :promo_labels
  end
end
