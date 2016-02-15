class CreateStaticData < ActiveRecord::Migration
  def change
    create_table :static_data do |t|
      t.string :city
      t.string :street
      t.string :tel1
      t.string :tel2

      t.string :facebook
      t.string :youtube
      t.string :google

      t.timestamps null: false
    end
  end
end
