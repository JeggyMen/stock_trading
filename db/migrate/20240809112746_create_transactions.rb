class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :stock, null: false, foreign_key: true
      t.string :transaction_type, null: false
      t.integer :quantity, null: false
      t.float :price, null: false

      t.timestamps
    end
  end
end
