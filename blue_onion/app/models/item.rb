class Item < ApplicationRecord
    # Validations
    validates :item_type, presence: true
    # Associations
    has_many :ordered_items
    has_many :orders, through: :ordered_items
  end