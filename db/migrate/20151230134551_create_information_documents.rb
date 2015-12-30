class CreateInformationDocuments < ActiveRecord::Migration
  def change
    create_table :information_documents do |t|
      t.string :title
      t.integer :position
      t.boolean :is_public
      t.attachment :document

      t.timestamps null: false
    end
  end
end
