# t.string :cart
# t.string :call_order
# t.string :contact_form
# t.string :offers_and_comments
# t.string :wd_order_product

class SupportEmail < ActiveRecord::Base
  attr_accessible *attribute_names

  rails_admin do
    navigation_label 'Настройки'
    weight -1

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
      field :wd_order_product do
        label 'Вікна двері (замовлення):'
      end
    end
  end
end
