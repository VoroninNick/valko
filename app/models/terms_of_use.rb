# t.string :title
# t.text :description
# t.boolean :published

class TermsOfUse < ActiveRecord::Base
  attr_accessible *attribute_names

  rails_admin do
    navigation_label 'Інші'

    label 'Правила користування'
    label_plural 'Правила користування'
    edit do
      field :published do
        label 'Чи актуальна версія?:'
      end
      field :title do
        label 'Назва:'
      end
      field :description, :ck_editor do
        label 'Контент сторінки:'
        help 'Використовувати теги h3, h4, h5, h6, p, blockquote, (ul, ol) li span'
      end
    end
  end
  scope :if_published, -> {where(published: true)}
end
