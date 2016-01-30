# t.integer :imageable_id
# t.string :imageable_type
class Price < ActiveRecord::Base
  attr_accessible *attribute_names
  belongs_to :priceable, polymorphic: true

  def to_slug
    key.parameterize
  end
  def save_slug
    self.slug = to_slug
  end
  before_save :save_slug

  rails_admin do
    visible false
    edit do
      field :key do
        label 'Назва: (ширина)'
      end
      field :value do
        label 'Значення: (ціна)'
      end
    end
  end

  def self.options_for_select
    order('LOWER(key)').map { |e| {key: e.key, value: e.value} }
  end
end
