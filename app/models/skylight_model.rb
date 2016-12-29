# t.string :name
# t.string :slug
# t.attachment :avatar
# t.belongs_to :skylight_producer
#
# t.text :short_description
# t.text :description

# t.string :subtitle
# t.text :header_description
# t.text :footer_description

class SkylightModel < ActiveRecord::Base
  attr_accessible *attribute_names

  attr_accessible :avatar
  has_attached_file :avatar,
                    styles: { thumb: "580x580>",
                              large: "1400x840>"},
                    convert_options: { thumb: "-quality 94 -interlace Plane",
                                       large: "-quality 94 -interlace Plane"},
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  belongs_to :skylight_producer

  has_one :seo, as: :seo_poly
  attr_accessible :seo
  accepts_nested_attributes_for :seo, allow_destroy: true
  attr_accessible :seo_attributes

  has_many :skylights
  attr_accessible :skylights
  accepts_nested_attributes_for :skylights, allow_destroy: true
  attr_accessible :skylights_attributes

  before_save { save_slug(name, slug) }


  rails_admin do
    navigation_label 'Покрівля огорожі'

    label 'Дахове вікно - моделі'
    label_plural 'Дахове вікно - моделі'

    list do

    end
    edit do
      field :skylight_producer do
        label 'Виробники:'
      end
      field :name do
        label 'Назва:'
      end
      field :avatar, :paperclip do
        label 'Зображення:'
        help 'розмір зображення 1400x840'
      end
      field :short_description do
        html_attributes rows: 10, cols: 100
        label 'Короткий опис:'
      end
      field :description, :ck_editor do
        label 'Характеристика:'
      end
      field :skylights do
        label 'Продукти:'
      end
      field :seo do
        label 'SEO'
      end
    end
  end

  def price
    skylights.first.price.to_i
  end
  def counted_price
    price.round()
  end
end
