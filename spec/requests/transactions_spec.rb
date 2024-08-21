# require 'rails_helper'

# RSpec.describe "Transactions", type: :request do
#   let(:trader) { create(:user, :trader) }
#   let(:other_user) { create(:user, :trader) }
#   let(:stock) { Stock.find_by(symbol: 'SM') || Stock.create!(symbol: 'SM', price: 880.00) }
#   let!(:transaction) { create(:transaction, user: trader, stock: stock, quantity: 2, price: stock.price, transaction_type: 'buy') }

#   before do
#     sign_in trader
#   end

#   describe "GET /transactions" do
#     it "allows a trader to access their transactions index" do
#       get transactions_path
#       expect(response).to have_http_status(:404)  
#       expect(response.body).to include(stock.symbol)
#       expect(response.body).to include(transaction.quantity.to_s)
#       expect(response.body).to include(transaction.price.to_s)
#       expect(response.body).to include(transaction.transaction_type)
#     end

#     it "redirects unauthorized users to the root path" do
#       sign_out trader
#       sign_in other_user

#       get transactions_path
#       expect(response).to redirect_to(root_path)
#       expect(flash[:alert]).to eq('Not authorized')
#     end
#   end
# end
