# t.string :name
# t.string :slug
# t.attachment :avatar
# t.text :short_description

class SkylightProducer < ActiveRecord::Base
  attr_accessible *attribute_names

  attr_accessible :avatar
  has_attached_file :avatar,
                    styles: { large: "240x140>"},
                    convert_options: { large: "-quality 94 -interlace Plane"},
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :skylight_models

  has_many :catalog_banners, as: :cat_banner
  attr_accessible :catalog_banners
  accepts_nested_attributes_for :catalog_banners, allow_destroy: true
  attr_accessible :catalog_banners_attributes

  has_one :seo, as: :seo_poly
  attr_accessible :seo
  accepts_nested_attributes_for :seo, allow_destroy: true
  attr_accessible :seo_attributes

  before_save { save_slug(name, slug) }

  rails_admin do
    navigation_label 'Покрівля огорожі'

    label 'Дахове вікно - виробник'
    label_plural 'Дахове вікно - виробники'

    list do
      field :name
      field :short_description
    end
    edit do
      field :name do
        label "Назва:"
      end
      field :avatar, :paperclip do
        label 'Зображення:'
        help 'розмір зображення 240x140'
      end
      field :short_description do
        label 'Короткий опис:'
        help 'Не більше 120 символів'
      end

      field :header_description, :ck_editor do
        label 'Верхній опис:'
      end
      field :catalog_banners do
        label 'Баннер:'
      end
      field :subtitle do
        label 'Нжижній блок назва:'
      end
      field :footer_description, :ck_editor do
        label 'Нижній опис:'
      end
      field :seo do
        label 'SEO'
      end
    end
  end
end
