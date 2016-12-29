class CreateSkylightProducers < ActiveRecord::Migration
  def change
    create_table :skylight_producers do |t|
      t.string :name
      t.string :slug
      t.attachment :avatar
      t.text :short_description

      t.timestamps null: false
    end
  end
end
