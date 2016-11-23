# t.string :title
# t.string :slug
# t.boolean :published
#
# t.string :appointment
# t.string :producer
#
# t.belongs_to :fastener
class FastenerOption < ActiveRecord::Base
  extend Enumerize
  attr_accessible *attribute_names

  belongs_to :fastener
  attr_accessible :fastener, :fastener_id
  validates :fastener, :presence => {:message => 'Виберіть кріплення!'}

  def initialize_title
    self.title = self.fastener.title
  end
  before_save :initialize_title
  before_save { save_slug(title, slug) }

  enumerize :producer, in: [:'info_global', :'goneba']
  enumerize :appointment, in: [:'to_metal', :'to_wood']

  has_many :fastener_color_options, as: :col_option
  attr_accessible :fastener_color_options
  accepts_nested_attributes_for :fastener_color_options, allow_destroy: true
  attr_accessible :fastener_color_options_attributes

  has_many :line_items

  # informations
  # has_and_belongs_to_many :informations, join_table: :information_metal_tile_details
  # attr_accessible :informations, :information_ids

  rails_admin do
    navigation_label 'Покрівля огорожі'

    label 'Кріплення - опція'
    label_plural 'Кріплення - опції'


    list do
      field :id
      field :title
      field :slug
      field :fastener
      field :appointment
      field :producer
    end
    edit do
      field :fastener do
        label 'Кріплення:'
      end
      field :appointment do
        label 'Призначення:'
      end
      field :producer do
        label 'Виробник:'
      end
      field :fastener_color_options do
        label 'Варіант кольору:'
      end

      # field :slug do
      #   label 'slug:'
      #   help 'не для редагування'
      # end
    end
  end

  def counted_price
    fastener_color_options.first.try(&:price)
    if fastener_color_options.first.try(:price).blank?
      return 0
    end
    (fastener_color_options.first.price).round()
  end

  def present_colors
    self.fastener_color_options.pluck(:title).uniq
  end

  def items_by_parent
    fastener.fastener_options
  end

  def appointments_by_item
    items_by_parent.pluck(:appointment).uniq
  end

  def producer_by_appointment(appointment)
    items_by_parent.where(appointment: appointment).pluck(:producer).uniq
  end

end
