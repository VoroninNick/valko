class JoinFastenerToPromoLabel < ActiveRecord::Migration
  def change
    create_join_table :fasteners, :promo_labels
  end
end
