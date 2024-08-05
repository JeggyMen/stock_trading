require 'rails_helper'

RSpec.describe 'User Login', type: :request do
  let!(:trader) { create(:user, email: 'trader@example.com', password: 'password', password_confirmation: 'password', role: 'trader') }
  let!(:admin) { create(:user, email: 'admin@example.com', password: 'password', password_confirmation: 'password', role: 'admin') }

  describe 'Trader user logs in and is redirected to the trader dashboard' do
    it 'redirects to the trader dashboard' do
      post user_session_path, params: { user: { email: trader.email, password: trader.password } }
      expect(response).to redirect_to(client_dashboard_path)
    end
  end

  describe 'Admin user logs in and is redirected to the admin dashboard' do
    it 'redirects to the admin dashboard' do
      post user_session_path, params: { user: { email: admin.email, password: admin.password } }
      expect(response).to redirect_to(admin_authenticated_root_path)
    end
  end
end