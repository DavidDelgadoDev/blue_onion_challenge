class CreateOrderedItems < ActiveRecord::Migration[6.1]
  def change
    create_table :ordered_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.float :price_per_item, null: false
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end