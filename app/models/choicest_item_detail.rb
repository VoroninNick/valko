class ChoicestItemDetail < ActiveRecord::Base
  extend Enumerize
  attr_accessible *attribute_names

  belongs_to :choicest_item
  attr_accessible :choicest_item, :choicest_item_id
  validates :choicest_item, :presence => {:message => 'Виберіть металочерепицю!'}

  def initialize_title
    self.title = self.choicest_item.title
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

  # has_many :line_items

  # informations
  # has_and_belongs_to_many :informations, join_table: :information_metal_tile_details
  # attr_accessible :informations, :information_ids

  rails_admin do
    navigation_label 'Покрівля огорожі'

    label 'Добірний елемент - опція'
    label_plural 'Добірні елементи - опції'


    list do
      field :id
      field :title
      field :slug
      field :choicest_item
      field :producer
      field :thickness
      field :coating
      field :protective_lamina
    end
    edit do
      # field :published do
      #   label 'Чи публікувати?:'
      # end
      field :choicest_item do
        label 'Добірні елемент:'
      end
      # field :width do
      #   label 'Ширина:'
      #   help 'вказується в міліметрах'
      # end
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
    if color_options.first.try(:price).blank?
      return 0
    end
    (color_options.first.price).round()
  end

  def present_colors
    self.color_options.pluck(:title).uniq
  end

  def items_by_parent
    choicest_item.choicest_item_details
  end

  def producers_by_item
    items_by_parent.pluck(:producer).uniq
  end

  def thickness_by_producers(producer)
    items_by_parent.where(producer: producer).pluck(:thickness).uniq
  end

  def coating_by_thickness
    items_by_parent.where(producer: self.producer).where(thickness: self.thickness).pluck(:coating).uniq
  end

  def protective_lamina_by_coating
    items_by_parent.where(producer: self.producer).where(thickness: self.thickness).where(coating: self.coating).pluck(:protective_lamina).uniq
  end
end
