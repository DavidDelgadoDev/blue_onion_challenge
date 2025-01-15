class AddCategoryToTransactionEntries < ActiveRecord::Migration[8.0]
  def change
    add_column :transaction_entries, :category, :string
  end
end
