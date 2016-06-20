class AddHeaderTitleToMosquitoGrid < ActiveRecord::Migration
  def change
    add_column :mosquito_grids, :header_title, :string
  end
end
