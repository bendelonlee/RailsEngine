FactoryBot.define do
  factory :invoice do
    customer
    merchant
    status { 0 }
    after :create do |inv|
      create :transaction, invoice: inv
    end
  end
end
