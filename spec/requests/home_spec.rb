require 'rails_helper'



RSpec.describe "Homes", type: :request do
  before do
    @user = FactoryBot.create(:user)  
    sign_in @user
  end

  describe "GET /index" do
    it "returns http success" do
      get home_index_path  
      expect(response).to have_http_status(:success)
    end
  end
end