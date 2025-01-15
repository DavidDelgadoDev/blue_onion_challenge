class TransactionEntry < ApplicationRecord
  # Associations
  belongs_to :order

  # Validations
  validates :debit, numericality: { greater_than_or_equal_to: 0.0 }
  validates :credit, numericality: { greater_than_or_equal_to: 0.0 }
  validates :description, presence: true
  validates :account, presence: true
  validates :category, presence: true
end