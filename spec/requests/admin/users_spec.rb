# spec/requests/admin/users_spec.rb
require 'rails_helper'

RSpec.describe "Admin::Users", type: :request do
  let(:admin) { create(:user, :admin) } 
  let!(:trader1) { create(:user, :trader) }
  let!(:trader2) { create(:user, :trader) }

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

  describe "GET /edit" do
    it "renders the edit user form" do
      get edit_admin_user_path(user)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Edit User")
    end
  end

  describe "PATCH /update" do
    it "updates the user's details" do
      patch admin_user_path(user), params: { user: { email: 'newemail@example.com' } }
      expect(response).to redirect_to(admin_dashboard_path)
      user.reload
      expect(user.email).to eq('newemail@example.com')
      expect(flash[:notice]).to eq('User was successfully updated.')
    end
  end

  describe "GET /show" do
    it "renders the show user details page" do
      get admin_user_path(user)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(user.email)
    end
  end

  describe "GET /admin/dashboard" do
    it "displays all traders" do
      get admin_dashboard_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(trader1.email)
      expect(response.body).to include(trader2.email)
    end
  end

end
