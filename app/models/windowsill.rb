# t.string :title
# t.string :slug
# t.text :description
# t.boolean :status
# t.belongs_to :brand
# t.boolean :published

# t.string :decor
# t.string :kapinos
# t.string :type
# t.string :material
# t.string :type_of_surface

# t.text :custom
# t.boolean :with_flap
# t.boolean :without_cap
# t.boolean :on_the_edge
# t.boolean :customised


# t.string :video_title
# t.string :video_url
# t.attachment :video_poster
# t.boolean :video_published
class Windowsill < ActiveRecord::Base
  attr_accessible *attribute_names
  belongs_to :brand

  has_and_belongs_to_many :promo_labels, join_table: :table_windowsills_promo_labels
  attr_accessible :promo_label_ids

  has_and_belongs_to_many :informations, join_table: :table_windowsills_informations
  has_and_belongs_to_many :promotions, join_table: :table_windowsills_promotions

  has_many :windowsill_photos
  attr_accessible :windowsill_photos
  accepts_nested_attributes_for :windowsill_photos, allow_destroy: true
  attr_accessible :windowsill_photos_attributes

  has_many :prices, as: :priceable
  attr_accessible :prices
  accepts_nested_attributes_for :prices, allow_destroy: true
  attr_accessible :prices_attributes

  before_save { save_slug(title, slug) }

  attr_accessible :video_poster
  has_attached_file :video_poster,
                    styles: { large: "440x300>"},
                    convert_options: { large: "-quality 94 -interlace Plane"},
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :video_poster, content_type: /\Aimage\/.*\Z/

  has_many :photo_galleries, as: :imageable
  attr_accessible :photo_galleries
  accepts_nested_attributes_for :photo_galleries, allow_destroy: true
  attr_accessible :photo_galleries_attributes

  extend Enumerize
  # attr_accessor :decor, :kapinos, :type, :material, :type_of_surface
  enumerize :wind_type, in: [:'internal', :'external']
  enumerize :decor, in: [:'wooden', :'stone', :'hi-tech', :'white']
  enumerize :kapinos, in: [:'round', :'direct']
  enumerize :material, in: [:'aluminum', :'steel', :'plastic']
  enumerize :type_of_surface, in: [:'wood', :'glossiness', :'opaque']


  def get_image
    windowsill_photos.first.try(:image)
  end

  rails_admin do
    navigation_label 'Підвіконня'

    label 'Підвіконня'
    label_plural 'Підвіконня'

    list do
      field :title do
        label 'Назва:'
      end
      field :get_image, :paperclip do
        label 'Аватар:'
      end
      field :description do
        label 'Опис'
      end
      field :brand do
        label 'Бренд'
      end
    end
    edit do
      # field :published do
      #   label 'Чи публікувати?'
      # end
      field :status do
        label 'Статус (Нове!):'
      end
      field :promo_labels do
        label 'Іконки акцій:'
      end
      field :title do
        label 'Назва:'
      end
      field :windowsill_photos do
        label 'Зображення (виробу):'
        help 'з заглушкою, без заглушки і тектстура'
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


      field :wind_type, :enum do
        label 'Тип:'
      end
      group :char_internal do
        label 'Характеристики внутрішніх'
        active false
        field :decor, :enum do
          label 'Декор:'
        end
        field :type_of_surface, :enum do
          label 'Вид поверхні:'
        end
        field :kapinos, :enum do
          label 'Капінос:'
        end
      end
      group :char_external do
        label 'Характеристики зовнішніх'
        active false
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
        active false
        field :customised do
          label 'Нестандарт:'
        end
        field :custom, :ck_editor do
          label 'Нестандартні вироби:'
          help 'заповнюється якщо потрібно щоб показувало вкладку "Нестандартні вироби"'
        end
      end

      group :gallery do
        label 'Галерея'
        active false
        field :photo_galleries do
          label 'Фотогалерея:'
        end
        field :video_published do
          label 'Чи публікувати відео?:'
        end
        field :video_title do
          label 'Назва відео:'
        end
        field :video_url do
          label 'Лінк на відео:'
        end
        field :video_poster, :paperclip do
          label 'Відео постер:'
          help 'розмір зображення 440x300'
        end

      end

    end
  end

  # scope :with_public, -> { where(:is_public => true).order(date_published: :desc)}
  scope :with_public, -> { where(:published => true)}
  scope :new_items, -> { where(:status => true)}

  paginates_per 12

  filterrific(
      default_filter_params: { sorted_by: 'created_at_desc' },
      available_filters: [
          :sorted_by,
          :with_brand,
          :with_type,
          :with_material,
          :with_decor,
          :with_type_of_surface,
          :with_kapinos
      ]
  )

  # sorted_by
  scope :sorted_by, lambda { |sort_key|
                    direction = (sort_key =~ /desc$/) ? 'desc' : 'asc'
                    case sort_key.to_s
                      when /^created_at_/
                        order("windowsills.created_at #{ direction }")
                      # when /^street_/
                      #   joins(:building_complex).order("LOWER(sigma_building_complexes.street) #{ direction }")
                      when /^title_/
                        order("windowsills.title #{ direction }")
                        # order("LOWER(sigma_building_complexes.name) #{ direction }").includes(:building_complex)
                        # joins(:building_complex).order("LOWER(sigma_building_complexes.name) #{ direction }")
                      else
                        raise(ArgumentError, "Invalid sort option: #{ sort_key.inspect }")
                    end

                  }

  def self.options_for_sorted_by
    [
        ['Дата(старіші перші)', 'created_at_asc'],
        ['Дата (новіші перші)', 'created_at_desc'],
        ['Назва (a-я)', 'title_asc'],
        ['Назва (я-а)', 'title_desc']
    # ['Назва вулиці (а-я)', 'building_complex_street_asc'],
    # ['Назва вулиці (я-а)', 'building_complex_street_desc']
    ]
  end

  # with brand
  scope :with_brand, lambda { |brand_id|
                                     joins(:brand).where(brands: { id: brand_id })
                                   }
  # with brand
  scope :with_type, lambda { |wind_type|
                     where(wind_type:  wind_type )
                   }
  # with material
  scope :with_material, lambda { |material|
                     where(material: [ *material])
                   }
 # with decor
  scope :with_decor, lambda { |decor|
                     where(decor: [ *decor])
                   }
 # with type_of_surface
  scope :with_type_of_surface, lambda { |surface|
                     where(surface: [ *surface])
                   }
  # with kapinos
  scope :with_kapinos, lambda { |kapinos|
                               where(kapinos: [ *kapinos])
                             }
end
