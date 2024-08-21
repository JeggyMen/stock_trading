class AddCurrentQuantityToTransaction < ActiveRecord::Migration[7.1]
  def change
    add_column :transactions, :current_quantity, :integer, null: false
  end
end
