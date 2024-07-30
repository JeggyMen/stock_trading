require 'rails_helper'

RSpec.describe "Admins", type: :request do
  describe "GET /dashboard" do
    it "returns http success" do
      get "/admins/dashboard"
      expect(response).to have_http_status(:success)
    end
  end

RSpec.describe 'Admin Users Management', type: :reqeust do
  let(:admin) { create(:admin) }
  let(:user) { create(:user, email: 'user@example.com') }
  let(:valid_attributes) { { email: 'newuser@example.com', password: 'password', password_confirmation: 'password', role: 'trader' } }
  let(:invalid_attributes) { { email: 'invalidemail', password: 'short', password_confirmation: 'mismatch', role: 'trader' } }
  



end
