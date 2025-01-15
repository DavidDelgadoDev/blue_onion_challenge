class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.datetime :ordered_at, null: false
      t.float :shipping, default: 0.0, null: false
      t.float :tax_rate, default: 0.0, null: false

      t.timestamps
    end
  end
end