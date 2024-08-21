FactoryBot.define do
  factory :transaction do
    user { nil }
    stock { nil }
    transaction_type { "MyString" }
    quantity { 1 }
    price { 1.5 }
  end
end
