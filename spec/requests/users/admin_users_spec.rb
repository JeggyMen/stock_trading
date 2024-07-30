require 'rails_helper'

RSpec.describe 'Admin Users', type: :request do
  let(:admin) { create(:admin) }
  let(:valid_attributes) { { email: 'newuser@example.com', password: 'password', password_confirmation: 'password', role: 'trader' } }
  let(:invalid_attributes) { { email: 'invalidemail', password: 'short', password_confirmation: 'mismatch', role: 'trader' } }

  before do
    sign_in admin
  end

  describe 'POST /admin/users' do
    context 'with valid attributes' do
      it 'creates a new user' do
        post '/admin/users', params: { user: valid_attributes }
        expect(response).to redirect_to(admin_users_path)
        expect(User.last.email).to eq('newuser@example.com')
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new user and shows an error' do
        post '/admin/users', params: { user: invalid_attributes }
        expect(response).to render_template(:new)
        expect(User.count).to eq(0)
      end
    end
  end
end