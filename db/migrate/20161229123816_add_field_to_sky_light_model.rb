class AddFieldToSkyLightModel < ActiveRecord::Migration
  def change
    change_table :skylight_producers do |t|
      t.string :subtitle
      t.text :header_description
      t.text :footer_description
    end
  end
end
