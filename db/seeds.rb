# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
admin_email = 'admin@example.com'
admin_password = 'password'

admin = User.find_or_initialize_by(email: admin_email)
admin.update(password: admin_password, password_confirmation: admin_password, role: 'admin')

puts "Seeded admin user: #{admin.email}"

Stock.create([
  { symbol: 'SM', price: 880.00 },
  { symbol: 'BDO', price: 140.00 },
  { symbol: 'JFC', price: 226.00 },
  { symbol: 'WLCON', price: 16.50 },
  { symbol: 'SMC', price: 98.00 },
  { symbol: 'SHLPH', price: 9.75 },
  { symbol: 'DMC', price: 11.16 },
  { symbol: 'BPI', price: 117.00 },
  { symbol: 'CEB', price: 27.80 },
  { symbol: 'AC', price: 588.00 },
  { symbol: 'PAL', price: 5.35 },
  { symbol: 'MBT', price: 65.00 },
  { symbol: 'SEVN', price: 69.00 },
  { symbol: 'LBC', price: 15.00 },
  { symbol: 'GLO', price: 2_178.00 }
])

puts "Stock seeded!"

#SM-investment
#Banco De Oro
#Jollibee Foods Corporation
#Wilcon Depot
#San Miguel Corporation
#Shell Pilipinas Corporation
#DMCI Holding, Inc
#Bank of the Philippine Islands
#Cebu Air, Inc.
#Ayala Corporation
#PAL Holdings Inc.
#Metro Bank and Trust Company
#Philippine Seven Corporation
#LBC Express Holdings, Inc.
#Globe Telecom, Inc.