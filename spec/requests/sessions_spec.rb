require 'rails_helper'

RSpec.describe 'User Sessions', type: :request do
  let!(:admin) { create(:user, role: 'admin') }
  let!(:trader) { create(:user, role: 'trader') }

  describe 'POST /users/sign_in' do
    context 'with valid credentials' do
      it 'logs in as admin and redirects to admin dashboard' do
        post user_session_path, params: { user: { email: admin.email, password: admin.password } }
        expect(response).to redirect_to(admin_authenticated_root_path)
      end

      it 'logs in as trader and redirects to trader dashboard' do
        post user_session_path, params: { user: { email: trader.email, password: trader.password } }
        expect(response).to redirect_to(client_dashboard_path)
      end
    end

    context 'with invalid role' do
      it 'does not log in and shows an error' do
        post user_session_path, params: { user: { email: trader.email, password: 'wrongpassword' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Invalid Email or password.')
      end
    end
  end
end