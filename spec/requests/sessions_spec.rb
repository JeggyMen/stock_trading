require 'rails_helper'

RSpec.describe 'User Sessions', type: :request do
  let!(:admin) { create(:admin) }
  let!(:trader) { create(:user, role: 'trader') }

  describe 'POST /users/sign_in' do
    context 'with valid credentials' do
      it 'logs in as admin and redirects to admin dashboard' do
        post user_session_path, params: { user: { email: admin.email, password: admin.password, role: 'admin' } }
        expect(response).to redirect_to(admin_root_path)
      end

      it 'logs in as trader and redirects to trader dashboard' do
        post user_session_path, params: { user: { email: trader.email, password: trader.password, role: 'trader' } }
        expect(response).to redirect_to(trader_root_path)
      end
    end

    context 'with invalid role' do
      it 'does not log in and shows an error' do
        post user_session_path, params: { user: { email: trader.email, password: trader.password, role: 'admin' } }
        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to eq('Invalid role selected for this user.')
      end
    end
  end
end