# t.string :title
# t.string :slug
# t.boolean :published
#
# t.string :producer
# t.string :thickness
# t.string :coating
# t.string :protective_lamina
#
# t.attachment :drawing
# t.integer :width
#
# t.belongs_to :metal_tile

class MetalTileDetail < ActiveRecord::Base
  extend Enumerize
  attr_accessible *attribute_names

  belongs_to :metal_tile
  attr_accessible :metal_tile, :metal_tile_id
  validates :metal_tile, :presence => {:message => 'Виберіть металочерепицю!'}

  # has_many :rr_details
  # attr_accessible :rr_details
  # accepts_nested_attributes_for :rr_details, allow_destroy: true
  # attr_accessible :rr_details_attributes

  # has_many :line_items
  # before_destroy :ensure_not_referenced_by_any_line_item

  def initialize_title
    self.title = self.metal_tile.title
  end
  before_save :initialize_title
  before_save { save_slug(title, slug) }

  enumerize :producer, in: [:'arcelor', :'ukraine', :'slovakia', :'china']
  enumerize :thickness, in: [:'super_elite_0_7', :'elite_0_5', :'premium_0_45', :'standart_0_4', :'econom_0_3']
  enumerize :coating, in: [:'glossy_polyester', :'polyester_mat', :'polyester_gloss_bilateral', :'aluzinc', :'zinc']
  enumerize :protective_lamina, in: [:'with_lamina', :'without_lamina']

  has_many :color_options, as: :col_option
  attr_accessible :color_options
  accepts_nested_attributes_for :color_options, allow_destroy: true
  attr_accessible :color_options_attributes

  # informations
  has_and_belongs_to_many :informations, join_table: :information_metal_tile_details
  attr_accessible :informations, :information_ids

  rails_admin do
    navigation_label 'Покрівля огорожі'

    label 'Металочерепиця - опція'
    label_plural 'Металочерепиці - опції'


    list do
      field :id
      field :slug
      field :producer
      field :thickness
      field :coating
      field :protective_lamina
    end
    edit do
      # field :published do
      #   label 'Чи публікувати?:'
      # end
      field :metal_tile do
        label 'Металочерепиця:'
      end
      field :width do
        label 'Ширина:'
        help 'вказується в міліметрах'
      end
      field :producer do
        label 'Виробник:'
      end
      field :thickness do
        label 'Товщина:'
      end
      field :coating do
        label 'Покриття:'
      end
      field :protective_lamina do
        label 'Захисна плівка:'
      end
      field :color_options do
        label 'Варіант кольору:'
      end

      # field :slug do
      #   label 'slug:'
      #   help 'не для редагування'
      # end
    end
  end

  def counted_price
    color_options.first.try(&:price)
    # gallery.try{|g| g.images.first }
    if width.nil? || color_options.first.try(:price).blank?
      return 0
    end
    (((width.to_f/1000) * 1) * color_options.first.price).round()
    # (((item.try(&:width).to_f/1000) * 1) * item.rr_details.first.price).round()
  end

  def present_colors
    self.color_options.pluck(:title).uniq
  end

  def producers_by_item
    MetalTileDetail.where(title: self.title).pluck(:producer).uniq
  end

  def thickness_by_producers(producer)
    MetalTileDetail.where(title: self.title).where(producer: producer).pluck(:thickness).uniq
  end

  def coating_by_thickness
    MetalTileDetail.where(title: self.title).where(producer: self.producer).where(thickness: self.thickness).pluck(:coating).uniq
  end

  def protective_lamina_by_coating
    MetalTileDetail.where(title: self.title).where(producer: self.producer).where(thickness: self.thickness).where(coating: self.coating).pluck(:protective_lamina).uniq
  end

end
