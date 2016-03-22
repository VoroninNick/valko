class CreateRrDescriptions < ActiveRecord::Migration
  def change
    create_table :rr_descriptions do |t|
      t.string :title
      t.text :description
      t.text :short_description

      t.timestamps null: false
    end
  end
end
