require 'rails_helper'

RSpec.describe "Admin::Transactions", type: :request do
  let(:admin) { create(:user, :admin) }
  let(:trader) { create(:user, :trader) }
  let!(:stock) { Stock.find_by(symbol: 'SM') || Stock.create!(symbol: 'SM', price: 880.00) }
  let!(:transaction) { Transaction.create!(user: trader, stock: stock, quantity: 2, price: stock.price, transaction_type: 'buy') }

  before do
    sign_in admin
  end

  describe "GET /admin/transactions" do
    it "allows admin to access the transactions index" do
      get admin_transactions_path
      expect(response).to have_http_status(:ok)
    end

    it "displays transaction details for admin" do
      get admin_transactions_path
      expect(response.body).to include(trader.email)
      expect(response.body).to include(stock.symbol)
      expect(response.body).to include(transaction.transaction_type)
      expect(response.body).to include(transaction.quantity.to_s)
    end
  end
end
