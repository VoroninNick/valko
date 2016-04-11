class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def total_price

    line_items.to_a.sum { |item| v = item.long; v = 0 if v.blank?;  item.total_price(v) }
  end

  def self.destroy_cart
    Cart.expired.destroy_all
  end
  scope :expired, -> { where('created_at <= ?', 24.hours.ago) }

  def total_quantity
    line_items.to_a.sum { |item| item.quantity }
  end

  after_save do
    Cart.destroy_cart
  end
end
