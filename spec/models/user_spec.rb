require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'callbacks' do
    context 'when a new user is created' do
      it 'sets the default status to pending if not approved' do
        new_trader = User.create(email: 'new_trader@example.com', password: 'password123', password_confirmation: 'password123', role: 'trader')
        expect(new_trader.approved).to be_falsey
      end
    end

    context 'when a user is updated' do
      it 'changes the user status to approved' do
        trader = User.create(email: 'trader@example.com', password: 'password123', password_confirmation: 'password123', role: 'trader', approved: false)
        trader.update(approved: true)
        expect(trader.approved).to be_truthy
      end
    end
  end
end