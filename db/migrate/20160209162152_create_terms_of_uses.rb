class CreateTermsOfUses < ActiveRecord::Migration
  def change
    create_table :terms_of_uses do |t|
      t.string :title
      t.text :description
      t.boolean :published

      t.timestamps null: false
    end
  end
end
