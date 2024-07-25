require 'rails_helper'

RSpec.describe 'UserLogin', type: :feature do
    it 'Client user logs in and is redirected to the client dashboard' do
        User.create(email: 'client@example.com', password: 'password', password_confirmation: 'password', role: 'client')
        visit new_user_session_path


        fill_in 'Email', with: 'client@example.com'
        fill_in 'Password', with: 'password'
        click_button 'Log in'

        expect(page).to have_current_path(client_dashboard_path)

    end

    it 'Admin user logs in and is redirected to the admin dashboard' do
        User.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password', role: 'admin')
        visit new_user_session_path

        fill_in 'Email', with: 'admin@example.com'
        fill_in 'Password', with: 'password'
        click_button 'Log in'

        expect(page).to have_current_path(admin_dashboard_path)
  end
end