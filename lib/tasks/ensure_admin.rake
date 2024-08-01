namespace :admin do
    desc "Ensure admin user exists"
    task ensure: :environment do
      admin_email = 'admin@example.com'
      admin_password = 'password'
      admin = User.find_or_initialize_by(email: admin_email)
      admin.update(password: admin_password, password_confirmation: admin_password, role: 'admin')
      puts "Ensured admin user: #{admin.email}"
    end
  end