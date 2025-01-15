class Order < ApplicationRecord
    # Validations
    validates :ordered_at, presence: true
    validates :shipping, numericality: { greater_than_or_equal_to: 0 }
    validates :tax_rate, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }
    # Associations
    has_many :ordered_items
    has_many :items, through: :ordered_items
    has_many :payments
    has_many :transaction_entries
    # Methods
    def total_price(base_price)
      base_price + shipping + (base_price * tax_rate)
    end
    def total_price_before_tax()
      ordered_items.sum { |oi| oi.price_per_item * oi.quantity }
    end
    def total_tax()
      total_price_before_tax() * tax_rate
    end
  end