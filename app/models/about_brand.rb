# t.string :title
# t.string :slug
# t.attachment :icon
# t.text :description
class AboutBrand < ActiveRecord::Base
  before_save { save_slug(title, slug) }

  attr_accessible *attribute_names

  attr_accessible :avatar
  has_attached_file :avatar
  validates_attachment :avatar,
                       :content_type => { :content_type => ['image/svg+xml'] }

  rails_admin do
    navigation_label 'Про нас'
    weight -1

    label 'Бренд'
    label_plural 'Бренд'

    field :title do
      label 'Назва:'
    end
    field :avatar, :paperclip do
      label 'Логотип:'
      help 'Логотип завантажувати типу svg'
    end
    field :description do
      html_attributes rows: 10, cols: 100
      label 'Опис:'
    end
  end

end
