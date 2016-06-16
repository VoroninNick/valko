# t.string :title
# t.string :slug
# t.string :mosquito_grid_type
# t.boolean :pockets
# t.boolean :curtain
# t.boolean :holders
# t.boolean :screws
# t.boolean :guides
# t.text :short_description
# t.text :description
# t.boolean :published
# t.float :min_square
class MosquitoItem < ActiveRecord::Base
  attr_accessible *attribute_names

  # include HasGallery
  extend HasGallery

  before_save { save_slug(title, slug) }

  has_many :mosquito_item_options
  attr_accessible :mosquito_item_options
  accepts_nested_attributes_for :mosquito_item_options, allow_destroy: true
  attr_accessible :mosquito_item_options_attributes

  extend Enumerize

  enumerize :mosquito_grid_type, in: [:'window', :'door', :'rolling', :'sliding']

  has_one :seo, as: :seo_poly
  attr_accessible :seo
  accepts_nested_attributes_for :seo, allow_destroy: true
  attr_accessible :seo_attributes

  has_and_belongs_to_many :informations, join_table: :information_mosquito_items
  attr_accessible :informations, :information_ids

  # validators
  validates :min_square, presence: true

  rails_admin do
    navigation_label 'Москітні сітки'

    label 'Одиниця каталогу'
    label_plural 'Одиниця каталогу'

    edit do
      extend HasGallery
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
      field :min_square do
        # required true
        label 'Мінімальна ціна за:'
      end
      group :mg_options do
        label 'Параметри'
        active true

        field :pockets do
          label 'Кишеньки:'
        end
        field :curtain do
          label 'Завіси:'
        end
        field :holders do
          label 'Тримачі:'
        end
        field :screws do
          label 'Шурупи:'
        end
        field :guides do
          label 'Направляючі:'
        end
      end

      field :description, :ck_editor do
        label 'Опис:'
      end
      field :mosquito_item_options do
        label 'Опції одиниці:'
      end

      rails_admin_gallery_fields

      field :seo do
        label 'SEO'
      end
    end
  end

  def present_colors
    self.mosquito_item_options.pluck(:title).uniq
  end

  def calculate_one_item(width = 1, height = 1)
    min_square = self.min_square
    price = self.mosquito_item_options.first.price
    square = width * height

    if square < min_square
      price * min_square
    else
      price * square
    end
  end

end
