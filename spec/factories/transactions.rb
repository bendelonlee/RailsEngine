FactoryBot.define do
  factory :transaction do
    invoice { nil }
    credit_card_number { 1 }
    credit_card_expiration_date { "2019-01-22 12:34:04" }
    result { 1 }
  end
end
