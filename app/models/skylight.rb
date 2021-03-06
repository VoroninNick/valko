# t.string :size
# t.string :price
# t.belongs_to :skylight_model

class Skylight < ActiveRecord::Base
  attr_accessible *attribute_names

  belongs_to :skylight_model
  has_many :line_items

  rails_admin do
    visible false
    edit do
      field :size do
        label 'Назва:'
      end
      field :price do
        label 'Ціна:'
      end
    end
  end

  def counted_price
    price.round()
  end
end
