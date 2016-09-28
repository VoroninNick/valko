# t.string :title
# t.string :subtitle
# t.string :slug
# t.text :header_description
# t.text :footer_description
# t.string :page_name

class WindowAndDoorPage < ActiveRecord::Base
  attr_accessible *attribute_names

  has_many :catalog_banners, as: :cat_banner
  attr_accessible :catalog_banners
  accepts_nested_attributes_for :catalog_banners, allow_destroy: true
  attr_accessible :catalog_banners_attributes

  has_one :seo, as: :seo_poly
  attr_accessible :seo
  accepts_nested_attributes_for :seo, allow_destroy: true
  attr_accessible :seo_attributes

  before_save { save_slug(title, slug) }

  rails_admin do
    navigation_label 'Вікна двері'
    weight -1

    label 'Головна сторінка каталогу'
    label_plural 'Головні сторінки каталогів'

    edit do
      field :page_name do
        label 'Назва сторінки:'
        help "Назву сторінки вказує програміст!!!! Через прив'язку по назві."
      end
      field :title do
        label 'Назва:'
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
