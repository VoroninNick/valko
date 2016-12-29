class CreateSkylightModels < ActiveRecord::Migration
  def change
    create_table :skylight_models do |t|
      t.string :name
      t.string :slug
      t.attachment :avatar
      t.belongs_to :skylight_producer

      t.text :short_description
      t.text :description


      t.timestamps null: false
    end
  end
end
