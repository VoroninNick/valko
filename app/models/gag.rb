# t.string :title
# t.string :slug
# t.belongs_to :brand
# t.attachment :image
# t.text :description
# t.boolean :published
# t.integer :price
class Gag < ActiveRecord::Base
  before_save { save_slug(title, slug) }

  attr_accessible *attribute_names

  attr_accessible :image
  has_attached_file :image,
                    styles: { thumb: "580x580>",
                              large: "1400x840>"},
                    convert_options: { thumb: "-quality 94 -interlace Plane",
                                       large: "-quality 94 -interlace Plane"},
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  belongs_to :brand

  rails_admin do
    navigation_label 'Підвіконня'

    label 'Заглушка'
    label_plural 'Заглушка'
    edit do
      field :published do
        label 'Чи публікувати?:'
      end
      field :title do
        label 'Назва:'
      end
      field :brand do
        label 'Бренд:'
      end
      field :image, :paperclip do
        label 'Зображення:'
        help 'розмір зображення 1400x840'
      end
      field :price do
        label 'Ціна:'
      end
      field :description do
        html_attributes rows: 10, cols: 100
        label 'Опис:'
      end
    end
  end

end
