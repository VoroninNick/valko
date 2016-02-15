# t.string :title
# t.text :description
# t.boolean :published

class Warranty < ActiveRecord::Base
  attr_accessible *attribute_names

  rails_admin do
    navigation_label 'Інше'

    label 'Доставка та гарантія'
    label_plural 'Доставка та гарантія'
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
