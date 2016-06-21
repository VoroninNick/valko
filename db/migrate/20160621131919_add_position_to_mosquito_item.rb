class AddPositionToMosquitoItem < ActiveRecord::Migration
  def change
    add_column :mosquito_items, :position, :integer
  end
end
