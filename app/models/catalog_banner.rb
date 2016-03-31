# t.string :title
# t.attachment :image
# t.integer :position
# t.boolean :published
# t.integer :cat_banner_id
# t.string :cat_banner_type
class CatalogBanner < ActiveRecord::Base
  attr_accessible *attribute_names

  belongs_to :cat_banner, polymorphic: true

  attr_accessible :image
  has_attached_file :image,
                    styles: { large: "980x400>"},
                    convert_options: { large: "-quality 94 -interlace Plane"},
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  rails_admin do
    visible false

    label 'Каталог баннер'
    label_plural 'Каталог баннер'
    edit do
      field :published do
        label 'Чи публікувати?'
      end
      field :title do
        label 'Назва:'
      end
      field :image, :paperclip do
        label 'Зображення:'
        help 'розмір зображення 980x400'
      end
      field :position do
        label 'Позиція:'
      end
    end
  end
  scope :with_public, -> { where(:published => true).order('position asc')}
end
