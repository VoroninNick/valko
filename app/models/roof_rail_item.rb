# t.string :producer
# t.string :thickness
# t.string :coating
# t.string :protective_lamina
#
# t.string :title
# t.string :slug
#
# t.text :short_description
# t.text :description
# t.boolean :published
#
# t.attachment :drawing
# t.integer :width
# t.string :item_type
class RoofRailItem < ActiveRecord::Base
  attr_accessible *attribute_names

  belongs_to :rr_description
  attr_accessible :rr_description, :rr_description_id
  validates :rr_description, :presence => {:message => 'Виберіть покрівля огорожі!'}

  has_many :rr_details
  attr_accessible :rr_details
  accepts_nested_attributes_for :rr_details, allow_destroy: true
  attr_accessible :rr_details_attributes

  def initialize_title
    self.title = self.rr_description.title
  end
  before_save :initialize_title
  before_save { save_slug(title, slug) }

  extend Enumerize
  enumerize :producer, in: [:'arcelor', :'ukraine', :'slovakia', :'china']
  enumerize :thickness, in: [:'elite_0_5', :'premium_0_45', :'standart_0_4', :'econom_0_3']
  enumerize :coating, in: [:'glossy_polyester', :'polyester_mat', :'polyester_gloss_bilateral', :'aluzinc', :'zinc']
  enumerize :protective_lamina, in: [:'with_lamina', :'without_lamina']

  rails_admin do
    navigation_label 'Покрівля огорожі'

    label 'Параметр (покрівля огорожі)'
    label_plural 'Параметри (покрівля огорожі)'

    list do
      field :id
      field :title
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
      field :rr_description do
        label 'Покрівля огорожі:'
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
      field :rr_details do
        label 'Одиниця:'
      end
    end
  end

  def producers_by_item
    RoofRailItem.where(title: self.title).pluck(:producer).uniq
  end

  def thickness_by_producers(producer)
    RoofRailItem.where(title: self.title).where(producer: producer).pluck(:thickness).uniq
  end

  def coating_by_thickness
    RoofRailItem.where(title: self.title).where(producer: self.producer).where(thickness: self.thickness).pluck(:coating).uniq
  end

  def protective_lamina_by_coating
    RoofRailItem.where(title: self.title).where(producer: self.producer).where(thickness: self.thickness).where(coating: self.coating).pluck(:protective_lamina).uniq
  end

  def present_colors
    # deck = RoofRailItem.where(title: self.title).where(producer: self.producer).where(thickness: self.thickness).where(coating: self.coating).where(protective_lamina: self.protective_lamina)
    self.rr_details.pluck(:title).uniq
  end

  def scenario

  end

end
