class DeckingInformation < ActiveRecord::Migration
  def change
    create_table :decking_informations do |t|
      t.belongs_to :rr_description
      t.belongs_to :information
    end
  end
end
