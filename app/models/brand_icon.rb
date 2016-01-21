# t.string :title
# t.string :slug
# t.attachment :icon
# t.belongs_to :brand
class BrandIcon < ActiveRecord::Base

  before_save { save_slug(title, slug) }

  attr_accessible *attribute_names
  belongs_to :brand

  attr_accessible :icon
  has_attached_file :icon
  validates_attachment :icon,
                       :content_type => { :content_type => ['image/svg+xml'] }

  # do_not_validate_attachment_file_type :icon

  rails_admin do
    visible false
    field :icon, :paperclip do
      label 'Аватарка:'
    end
    field :title do
      label 'Назва:'
    end
  end
end
