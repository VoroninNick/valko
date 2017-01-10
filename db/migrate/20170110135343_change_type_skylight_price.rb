class ChangeTypeSkylightPrice < ActiveRecord::Migration
  def change
    change_column(:skylights, :price, 'integer USING CAST(price AS integer)')
  end
end
