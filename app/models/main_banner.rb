class MainBanner < ActiveRecord::Base
  attr_accessible *attribute_names

  has_many :main_banner_images
  attr_accessible :main_banner_images
  accepts_nested_attributes_for :main_banner_images, allow_destroy: true
  attr_accessible :main_banner_images_attributes

  rails_admin do
    label "Головний баннер"
    edit do
      field :title do
        label 'Назва:'
      end
      field :description do
        label 'Опис:'
      end
      field :main_banner_images do
        label 'Зображення:'
      end
    end
  end
end
