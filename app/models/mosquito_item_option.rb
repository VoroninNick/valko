# t.string :title
# t.string :slug
# t.integer :price
# t.belongs_to :mosquito_item
# t.has_attached_file :image
class MosquitoItemOption < ActiveRecord::Base
  attr_accessible *attribute_names
  attr_accessible :image
  belongs_to :mosquito_item

  before_save { save_slug(title, slug) }

  attr_accessible :image
  has_attached_file :image,
                    styles: { thumb: "580x580>",
                              large: "1400x840>"},
                    convert_options: { thumb: "-quality 94 -interlace Plane",
                                       large: "-quality 94 -interlace Plane"},
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  belongs_to :windowsill


  extend Enumerize

  enumerize :title, in: [:white, :brown, :dark_brown, :anthracite, :nut, :winchester, :mahoney, :golden_oak]

  rails_admin do
    label 'Одиниця каталогу - опції'
    label_plural 'Одиниця каталогу - опція'

    visible false
    edit do
      field :title do
        label 'Назва:'
      end
      field :price do
        label 'Ціна:'
      end
      field :image, :paperclip do
        label 'Зображення:'
        help 'розмір зображення 1400x840'
      end
    end
  end
end
