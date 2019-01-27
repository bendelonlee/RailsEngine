require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it { should have_many :invoices }
  end

  describe 'instance methods' do
    it 'favorite merchant' do
      customer = create(:customer)
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      item_1 = create(:item, merchant: merchant_1)
      item_2 = create(:item, merchant: merchant_2)

      invoice = create_list(:invoice, 4, customer: customer, merchant: merchant_1, items: [item_1])
      invoice = create_list(:invoice, 1, customer: customer, merchant: merchant_2, items: [item_2])
      expect(customer.favorite_merchant).to eq(merchant_1)
    end
  end
end
