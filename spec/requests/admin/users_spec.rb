# spec/requests/admin/users_spec.rb
require 'rails_helper'

RSpec.describe "Admin::Users", type: :request do
  let(:admin) { create(:user, :admin) } 

  before do
    sign_in admin 

  describe "GET /index" do
    pending "add some examples (or delete) #{__FILE__}"
  end

  describe "POST /admin/users" do
    it "creates a new user with the role of trader" do
      post admin_users_path, params: { user: { email: 'newuser@example.com', password: 'password123', password_confirmation: 'password123' } }
      
      expect(response).to have_http_status(:redirect)
      expect(User.last.email).to eq('newuser@example.com')
      expect(User.last.role).to eq('trader')
    end
  end
end
