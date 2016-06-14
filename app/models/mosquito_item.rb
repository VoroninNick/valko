# t.string :title
# t.string :slug
# t.string :mosquito_grid_type
# t.string :mosquito_grid_option
# t.text :short_description
# t.text :description
# t.boolean :published
class MosquitoItem < ActiveRecord::Base
  attr_accessible *attribute_names

  before_save { save_slug(title, slug) }

  has_many :mosquito_item_options
  attr_accessible :mosquito_item_options
  accepts_nested_attributes_for :mosquito_item_options, allow_destroy: true
  attr_accessible :mosquito_item_options_attributes

  extend Enumerize

  enumerize :mosquito_grid_type, in: [:'window', :'door', :'rolling', :'sliding']
  enumerize :mosquito_grid_option, in: [:'pockets', :'curtain']

  has_one :seo, as: :seo_poly
  attr_accessible :seo
  accepts_nested_attributes_for :seo, allow_destroy: true
  attr_accessible :seo_attributes


  rails_admin do
    navigation_label 'Москітні сітки'

    label 'Одиниця каталогу'
    label_plural 'Одиниця каталогу'

    edit do
      # field :published do
      #   label 'Чи публікувати?:'
      # end
      field :mosquito_grid_type do
        label 'Різновид:'
      end
      field :title do
        label 'Назва:'
      end
      field :short_description do
        label 'Короткий опис:'
      end
      field :mosquito_grid_option do
        label 'Параметри:'
      end
      field :description, :ck_editor do
        label 'Опис:'
      end
      field :mosquito_item_options do
        label 'Опції одиниці:'
      end

      # group :gallery do
      #   label 'Галерея'
      #   active false
      #   field :photo_galleries do
      #     label 'Фотогалерея:'
      #   end
      #   field :video_published do
      #     label 'Чи публікувати відео?:'
      #   end
      #   field :video_title do
      #     label 'Назва відео:'
      #   end
      #   field :video_url do
      #     label 'Лінк на відео:'
      #   end
      #   field :video_poster, :paperclip do
      #     label 'Відео постер:'
      #     help 'розмір зображення 440x300'
      #   end
      #
      # end

      field :seo do
        label 'SEO'
      end
    end
  end
end
