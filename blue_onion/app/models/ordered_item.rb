class OrderedItem < ApplicationRecord
  # Associations
  belongs_to :order
  belongs_to :item

  # Validations
  validates :price_per_item, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end