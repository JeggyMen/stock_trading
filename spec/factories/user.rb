FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    role { 'trader' }

    factory :admin do
      email { 'admin@example.com' }
      role { 'admin' }
    end
  end
end