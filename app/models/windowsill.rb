# t.string :title
# t.string :slug
# t.text :description
# t.boolean :status
# t.belongs_to :brand
# t.boolean :published
class Windowsill < ActiveRecord::Base
  attr_accessible *attribute_names
  belongs_to :brand

  has_many :windowsill_photos
  attr_accessible :windowsill_photos
  accepts_nested_attributes_for :windowsill_photos, allow_destroy: true
  attr_accessible :windowsill_photos_attributes

  has_many :prices, as: :priceable
  attr_accessible :prices
  accepts_nested_attributes_for :prices, allow_destroy: true
  attr_accessible :prices_attributes

  def to_slug
    title.parameterize
  end
  def save_slug
    self.slug = to_slug
  end
  before_save :save_slug



  rails_admin do
    navigation_label 'Підвіконня'

    label 'Підвіконня'
    label_plural 'Підвіконня'

    edit do
      field :published do
        label 'Чи публікувати?'
      end
      field :status do
        label 'Статус (Нове!):'
      end
      field :title do
        label 'Назва:'
      end
      field :windowsill_photos do
        label 'Зображення:'
      end
      field :prices do
        label 'Ціни:'
      end
      field :brand do
        label 'Бренд:'
      end
      field :description, :ck_editor do
        label 'Опис:'
      end
    end
  end
end
