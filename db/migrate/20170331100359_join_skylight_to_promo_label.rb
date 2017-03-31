class JoinSkylightToPromoLabel < ActiveRecord::Migration
  def change
    create_join_table :promo_labels, :skylight_models
  end
end
