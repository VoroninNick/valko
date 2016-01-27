# t.string :title
# t.attachment :image
# t.integer :position
# t.boolean :published
class AboutBanner < ActiveRecord::Base
  attr_accessible * attribute_names
  attr_accessible :image
  has_attached_file :image,
                    styles: { large: "980x400>"},
                    convert_options: { large: "-quality 94 -interlace Plane"},
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  rails_admin do
    navigation_label 'Про нас'

    label 'Баннер'
    label_plural 'Баннер'
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
  scope :published, where(published: 't').order(position: :desc)
end
