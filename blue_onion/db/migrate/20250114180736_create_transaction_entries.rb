class CreateTransactionEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :transaction_entries do |t|
      t.float :debit, default: 0.0
      t.float :credit, default: 0.0
      t.string :description
      t.string :account
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end