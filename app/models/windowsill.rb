# t.string :title
# t.string :slug
# t.text :description
# t.boolean :status
# t.belongs_to :brand
# t.boolean :published

# t.text :custom
# t.boolean :with_flap
# t.boolean :without_cap
# t.boolean :on_the_edge
# t.boolean :customised
class Windowsill < ActiveRecord::Base
  attr_accessible *attribute_names
  belongs_to :brand

  has_many :windowsill_photos
  attr_accessible :windowsill_photos
  accepts_nested_attributes_for :windowsill_photos, allow_destroy: true
  attr_accessible :windowsill_photos_attributes

  has_many :prices, as: :priceable
  attr_accessible :prices
  accepts_nested_attributes_for :prices, allow_destroy: true
  attr_accessible :prices_attributes

  before_save { save_slug(title, slug) }


  extend Enumerize
  # attr_accessor :decor, :kapinos, :type, :material, :type_of_surface
  enumerize :type, in: [:'internal', :'external']
  enumerize :decor, in: [:'wooden', :'stone', :'hi-tech', :'white']
  enumerize :kapinos, in: [:'round', :'direct']
  enumerize :material, in: [:'aluminum', :'steel', :'plastic']
  enumerize :type_of_surface, in: [:'wood', :'glossiness', :'opaque']

  rails_admin do
    navigation_label 'Підвіконня'

    label 'Підвіконня'
    label_plural 'Підвіконня'

    edit do
      field :published do
        label 'Чи публікувати?'
      end
      field :status do
        label 'Статус (Нове!):'
      end
      field :title do
        label 'Назва:'
      end
      field :windowsill_photos do
        label 'Зображення:'
      end
      field :prices do
        label 'Ціни:'
      end
      field :brand do
        label 'Бренд:'
      end
      field :description, :ck_editor do
        label 'Опис:'
      end


      field :type, :enum do
        label 'Тип:'
      end
      group :char_internal do
        label 'Характеристики внутрішніх'
        field :decor, :enum do
          label 'Декор:'
        end
        field :type_of_surface, :enum do
          label 'Вид поверхні:'
        end
      end
      group :char_external do
        label 'Характеристики зовнішніх'
        field :kapinos, :enum do
          label 'Капінос:'
        end
        field :material, :enum do
          label 'Матеріал:'
        end
      end
      group :options do
        label 'Додаткові опції'
        field :with_flap do
          label 'З заглушкою:'
        end
        field :without_cap do
          label 'Без заглушки:'
        end
        field :on_the_edge do
          label 'З кромкою:'
        end
      end
      group :custom_filed do
        label 'Нестандартні'
        field :customised do
          label 'Нестандарт:'
        end
        field :custom, :ck_editor do
          label 'Нестандартні вироби:'
        end
      end
    end
  end

  # scope :with_public, -> { where(:is_public => true).order(date_published: :desc)}
  scope :with_public, -> { where(:published => true)}
  scope :new_items, -> { where(:status => true)}
end
