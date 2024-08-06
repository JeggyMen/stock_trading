require 'rails_helper'

RSpec.describe "Stocks", type: :request do
  describe "GET /index" do
    it "returns http found" do
      get "/stocks/index"
      expect(response).to have_http_status(:found)
    end
  end

end
