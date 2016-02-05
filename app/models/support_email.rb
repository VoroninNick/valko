# t.string :cart
# t.string :call_order
# t.string :contact_form
# t.string :offers_and_comments
class SupportEmail < ActiveRecord::Base
  attr_accessible *attribute_names

  rails_admin do
    navigation_label 'Настройки'

    label 'Електронна скринька'
    label_plural 'Електронні скриньки'

    list do
      field :cart do
        label 'Корзина:'
      end
      field :call_order do
        label 'Замовити дзвінок:'
      end
      field :contact_form do
        label 'Контактна форма:'
      end
      field :offers_and_comments do
        label 'Пропозиції та зауваження:'
      end
    end
  end
end
