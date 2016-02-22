# t.string :title
# t.string :slug

class Page < ActiveRecord::Base
  attr_accessible *attribute_names

  before_save { save_slug(title, slug) }
  has_one :seo, as: :seo_poly
  attr_accessible :seo
  accepts_nested_attributes_for :seo, allow_destroy: true
  attr_accessible :seo_attributes

  rails_admin do
    navigation_label 'Інші'

    label 'Статична сторінка'
    label_plural 'Статичні сторінки'
    list do
      field :title do
        label 'Назва сторінки:'
      end
      field :slug do
        label 'Транслітерація:'
      end
    end
    edit do
      field :title do
        label 'Назва сторінки:'
        help 'Назви сторінок не міняти!'
      end
      field :seo do
        label 'SEO'
      end
    end
  end
end
