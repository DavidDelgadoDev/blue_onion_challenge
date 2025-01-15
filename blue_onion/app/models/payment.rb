class Payment < ApplicationRecord
  # Associations
  belongs_to :order

  # Validations
  validates :payment_id, presence: true, uniqueness: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end