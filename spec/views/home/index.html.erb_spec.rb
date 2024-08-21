require 'rails_helper'

# RSpec.describe "home/index.html.erb", type: :view do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

RSpec.describe "Stocks", type: :request do
  let(:user) { create(:user, :trader, approved: true) }
  let!(:stocks) { create_list(:stock, 5) }

  before do
    sign_in user
  end

  describe "GET /stocks" do
    it "displays all stocks and has 'Add to Portfolio' link" do
      get stocks_path

      expect(response).to have_http_status(:ok)
      stocks.each do |stock|
        expect(response.body).to include(stock.symbol)
        expect(response.body).to include(stock.price.to_s)
      end
    end
  end
end
