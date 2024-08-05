require 'rails_helper'

RSpec.describe "Admin::Users", type: :request do
  let(:admin) { create(:user, :admin) }
  let!(:trader1) { create(:user, :trader) }
  let!(:trader2) { create(:user, :trader) }
  let!(:pending_trader) { create(:user, :trader, approved: false) }
  let!(:approved_trader) { create(:user, :trader, approved: true) }

  before do
    sign_in admin
  end

  describe "POST /admin/users" do
    it "creates a new user with the role of trader" do
      post admin_users_path, params: { user: { email: 'newuser@example.com', password: 'password123', password_confirmation: 'password123' } }
      
      expect(response).to have_http_status(:redirect)
      expect(User.last.email).to eq('newuser@example.com')
      expect(User.last.role).to eq('trader')
      expect(User.last.approved).to be_falsey
    end
  end

  describe "GET /admin/users/:id/edit" do
    it "renders the edit user form" do
      get edit_admin_user_path(trader1)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Edit User")
    end
  end

  describe "UPDATE /admin/users/:id" do
    it "updates the user's details" do
      patch admin_user_path(trader1), params: { user: { email: 'newemail@example.com' } }
      expect(response).to redirect_to(admin_authenticated_root_path)
      trader1.reload
      expect(trader1.email).to eq('newemail@example.com')
      expect(flash[:notice]).to eq('Trader was successfully updated.')
    end
  end

  describe "GET /admin/users/:id" do
    it "renders the show user details page" do
      get admin_user_path(trader1)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(trader1.email)
    end
  end

  describe "GET /admin/dashboard" do
  before do
    pending_trader.update(approved: false)
    approved_trader.update(approved: true)
  end

  it "displays all traders" do
    get admin_authenticated_root_path
    expect(response).to have_http_status(:ok)
    expect(response.body).to include(trader1.email)
    expect(response.body).to include(trader2.email)
  end

  it "displays only pending traders" do
    get admin_authenticated_root_path
    expect(response).to have_http_status(:ok)
    expect(response.body).to include(pending_trader.email)
  end
end

  describe "GET /admin/users/:id/approve" do
    it "approves a pending trader" do
      get approve_admin_user_path(pending_trader)
      expect(response).to redirect_to(admin_authenticated_root_path)
      pending_trader.reload
      expect(pending_trader.approved).to be_truthy
      expect(flash[:notice]).to eq('Trader was successfully approved.')
    end
  end
end
