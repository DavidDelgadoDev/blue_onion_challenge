class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :item_type, null: false

      t.timestamps
    end
  end
end