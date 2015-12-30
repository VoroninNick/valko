# t.string :title
# t.integer :position
# t.boolean :is_public
# t.attachment :document
class InformationDocument < ActiveRecord::Base
  attr_accessible *attribute_names
  attr_accessible :document

  has_attached_file :document
  validates_attachment_content_type :document,
                                    :content_type => %w(application/pdf),
                                    :if => :file_attached?

  validates_attachment_size :document, :less_than => 30.megabytes

  def file_attached?
    self.document.file?
  end

  rails_admin do
    navigation_label 'Інформація'
    label 'Документ'
    label_plural 'Документи'

    edit do
      field :is_public do
        label 'Чи публікувати?'
      end
      field :position do
        label 'Позиція:'
      end
      field :title do
        label 'Назва:'
      end
      field :document, :paperclip do
        label 'PDF Документ:'
      end
    end
  end
  scope :with_public, -> { where(:is_public => true).order('position asc')}
end
