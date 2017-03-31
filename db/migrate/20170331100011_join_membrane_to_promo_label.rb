class JoinMembraneToPromoLabel < ActiveRecord::Migration
  def change
    create_join_table :membranes, :promo_labels
  end
end
