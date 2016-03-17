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

  has_many :rr_details
  attr_accessible :rr_details
  accepts_nested_attributes_for :rr_details, allow_destroy: true
  attr_accessible :rr_details_attributes

  before_save { save_slug(title, slug) }

  extend Enumerize
  enumerize :producer, in: [:'arcelor', :'ukraine', :'china', :'slovakia']
  enumerize :thickness, in: [:'elite_0_5', :'premium_0_45', :'standart_0_4']
  enumerize :coating, in: [:'zinc', :'aluzinc', :'glossy_polyester', :'polyester_mat', :'polyester_gloss_bilateral']
  enumerize :protective_lamina, in: [:'with_lamina', :'without_lamina']

  rails_admin do
    navigation_label 'Покрівля огорожі'

    label 'Покрівля огорожі'
    label_plural 'Покрівля огорожі'

    edit do
      field :published do
        label 'Чи публікувати?:'
      end
      field :title do
        label 'Назва:'
      end
      field :short_description do
        html_attributes rows: 10, cols: 100
        label 'Короткий опис:'
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
      field :description, :ck_editor do
        label 'Повний пис:'
      end
      field :rr_details do
        label 'Одиниця:'
      end
    end
  end

  def producers_by_item
    RoofRailItem.where(title: self.title).pluck(:producer).uniq
  end

  def thickness_by_producers
    RoofRailItem.where(title: self.title).where(producer: self.producer).pluck(:thickness).uniq
  end

  def coating_by_thickness
    RoofRailItem.where(title: self.title).where(producer: self.producer).where(thickness: self.thickness).pluck(:coating).uniq
  end

  def protective_lamina_by_coating
    RoofRailItem.where(title: self.title).where(producer: self.producer).where(thickness: self.thickness).where(coating: self.coating).pluck(:protective_lamina).uniq
  end

  def present_colors

  end

end
