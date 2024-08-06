class CreateJoinTableUsersStocks < ActiveRecord::Migration[7.1]
  def change
    create_join_table :users, :stocks do |t|
       t.index :user_id
       t.index :stock_id
    end
  end
end
