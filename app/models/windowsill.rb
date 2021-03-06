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

# t.string :color_type
# t.string :color

# t.integer :edge_price
class Windowsill < ActiveRecord::Base

  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item


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

  def to_slug
    "#{brand.slug}-#{id}-#{title.parameterize}"
  end
  def save_slug
    self.slug = to_slug
  end
  before_save :save_slug

  attr_accessible :video_poster
  has_attached_file :video_poster,
                    styles: { large: "440x300>"},
                    convert_options: { large: "-quality 94 -interlace Plane"},
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :video_poster, content_type: /\Aimage\/.*\Z/
  validates_presence_of :brand, :message => "Виберіть бренд!"


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
  enumerize :color_type, in: [:'mat', :'glossy']
  enumerize :color, in: [:'white', :'milk', :'silver', :'anthracite', :'yellow', :'blue', :'brick', :'red', :'cherry', :'brick_red', :'brown', :'dark_brown', :'green', :'light_green', :'zinc', :'nut', :'golden_oak']

  # attr_accessor :color_type

  def get_image
    windowsill_photos.first.try(:image)
  end

  has_one :seo, as: :seo_poly
  attr_accessible :seo
  accepts_nested_attributes_for :seo, allow_destroy: true
  attr_accessible :seo_attributes

  rails_admin do
    navigation_label 'Підвіконня відливи'
    weight -1

    label 'Підвіконня'
    label_plural 'Підвіконня'

    object_label_method do
      :slug
    end

    list do
      field :id do

      end
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
      field :slug do

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
        field :color_type, :enum do
          label 'Тип кольору:'
        end
        field :color, :enum do
          label 'Колір:'
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
        field :edge_price do
          label 'З кромкою:'
          help 'ціна кромки'
        end
        # field :on_the_edge do
        #   label 'З кромкою:'
        # end
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
      field :seo do
        label 'SEO'
      end
    end
  end

  # scope :with_public, -> { where(:is_public => true).order(date_published: :desc)}
  scope :with_public, -> { where(:published => true)}
  scope :new_items, -> { where(:status => true)}

  paginates_per 12


  searchable do
    text :title, :description
  end


  filterrific(
      default_filter_params: { sorted_by: 'title_asc' },
      available_filters: [
          :sorted_by,
          :with_brand,
          :with_type,
          :with_material,
          :with_decor,
          :with_surface,
          :with_kapinos,
          :with_color_type,
          :with_color
      ]
  )

  # sorted_by
  scope :sorted_by, lambda { |sort_key|
                    direction = (sort_key =~ /desc$/) ? 'desc' : 'asc'
                    case sort_key.to_s
                      when /^title_/
                        order("windowsills.title #{ direction }")
                      when /^created_at_/
                        order("windowsills.created_at #{ direction }")
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
  # scope :with_type, lambda { |wind_type|

                   # }
  # with material
  scope :with_material, lambda { |material|
                     where(material: [ *material])
                   }
 # with decor
  scope :with_decor, lambda { |decor|
                     where(decor: [ *decor])
                   }
 # with surface
  scope :with_surface, lambda { |surface|
                     where(type_of_surface: [ *surface])
                   }
  # with kapinos
  scope :with_kapinos, lambda { |kapinos|
                               where(kapinos: [ *kapinos])
                             }
  # with color type
  scope :with_color_type, lambda { |value|
                       where(color_type: [ *value])
                     }
  # with color
  scope :with_color, lambda { |value|
                          where(color: [ *value])
                        }

  scope :with_type, ->(type) {
    Windowsill.self_with_type(type, self)
  }

  def self.self_with_type(type, relation)

    if type.blank?
      return relation.where(wind_type: [:'internal', :'external'])
    end

    if type == "gag"
      return Gag.all
    else
      return relation.where(wind_type:  type )
    end
  end

  private
  def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
  end
end
