require 'rails_helper'

RSpec.describe "UserStocks", type: :request do
  let(:user) { create(:user, :trader, approved: true, balance: 5_000) }
  let!(:stock) { create(:stock, price: 100) }

  before do
    sign_in user
  end

  describe "GET /stocks/:id/add_to_portfolio" do
      context "when the stock is not yet added to the portfolio" do
        it "adds the stock to the trader's portfolio" do
          expect {
            get add_to_portfolio_stock_path(stock), params: { quantity: 1, price: stock.price, transaction_type: 'buy' }
          }.to change { user.stocks.count }.by(0)

        end
      end

      context "when the stock is already in the portfolio" do
        before do
          user.user_stocks.create(stock: stock)
        end

        it "does not add the stock again and shows an alert message" do
          expect {
            get add_to_portfolio_stock_path(stock), params: { quantity: 1, price: stock.price, transaction_type: 'buy' }
          }.not_to change { user.stocks.count }

        end
      end
    end
  describe "POST /stocks/:id/buy" do
    context "with sufficient balance and valid quantity" do
      it "creates a buy transaction and updates the user's balance" do
        post buy_stock_path(stock), params: { quantity: 2 }
        expect(Transaction.count).to eq(1)
        expect(user.reload.balance).to eq(5_000 - (stock.price * 2))
        expect(flash[:notice]).to eq("Successfully bought 2 shares of #{stock.symbol}.")
        expect(response).to redirect_to(client_dashboard_path)
      end
    end

    context "with invalid quantity" do
      it "does not create a transaction and shows an alert message" do
        post buy_stock_path(stock), params: { quantity: 0 }

        expect(Transaction.count).to eq(0)
        expect(flash[:alert]).to eq('Quantity must be a positive number.')
        expect(response).to redirect_to(client_dashboard_path)
      end
    end

    context "with insufficient balance" do
      before do
        user.update!(balance: 50) 
      end

      it "does not create a transaction and shows an alert message" do
        post buy_stock_path(stock), params: { quantity: 2 }

        expect(Transaction.count).to eq(0)
        expect(flash[:alert]).to eq('Insufficient balance.')
        expect(response).to redirect_to(client_dashboard_path)
      end
    end
  end

  describe "POST /stocks/:id/sell" do
    context "when the user owns the stock" do
      before do
        user.transactions.create!(stock: stock, quantity: 5, price: stock.price, transaction_type: 'buy')
      end

      it "creates a sell transaction and updates the user's balance" do
        post sell_stock_path(stock), params: { quantity: 2 }

        expect(Transaction.count).to eq(2) 
        expect(user.reload.balance).to eq(5_000 + (stock.price * 2))
        expect(flash[:notice]).to eq("Successfully sold 2 shares of #{stock.symbol}.")
        expect(response).to redirect_to(client_dashboard_path)
      end
    end

    context "when the user does not own the stock" do
      it "does not create a sell transaction and shows an alert message" do
        post sell_stock_path(stock), params: { quantity: 2 }

        expect(Transaction.count).to eq(0) 
        expect(flash[:alert]).to eq('You do not own this stock.')
        expect(response).to redirect_to(client_dashboard_path)
      end
    end

    context "with invalid quantity" do
      before do
        user.transactions.create!(stock: stock, quantity: 5, price: stock.price, transaction_type: 'buy')
      end

      it "does not create a sell transaction and shows an alert message" do
        post sell_stock_path(stock), params: { quantity: 0 }

        expect(Transaction.count).to eq(1) 
        expect(flash[:alert]).to eq('Quantity must be greater than 0')
        expect(response).to redirect_to(client_dashboard_path)
      end
    end
  end

end