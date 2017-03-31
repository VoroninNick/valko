class JoinSealantToPromoLabel < ActiveRecord::Migration
  def change
    create_join_table :promo_labels, :sealants
  end
end
