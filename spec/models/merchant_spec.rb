require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoices) }
  end
  describe "class methods" do
    it '.most_revenue' do
      m1, m2, m3, m4, m5 = create_list(:merchant, 5)

      item_4 = create(:item, merchant: m5)
      item_3 = create(:item,  merchant: m1)
      item_2 = create(:item, merchant: m4)
      item_1 = create(:item,  merchant: m2)
      item_0 = create(:item,  merchant: m3)

      invoice_4 = create(:invoice, merchant: m5 )
      invoice_3 = create(:invoice,  merchant: m1 )
      invoice_2 = create(:invoice, merchant: m4 )
      invoice_1 = create(:invoice,  merchant: m2 )
      invoice_0 = create(:invoice,  merchant: m3 )

      create_list(:invoice_item, 5, quantity: 2, item: item_4, unit_price: 1000, invoice: invoice_4)
      create_list(:invoice_item, 1, quantity: 2, item: item_3, unit_price: 2000, invoice: invoice_3)
      create_list(:invoice_item, 2, quantity: 4, item: item_2, unit_price: 100, invoice: invoice_2)
      create_list(:invoice_item, 1, quantity: 14, item: item_1, unit_price: 10, invoice: invoice_1)

      expect(Merchant.most_revenue(3)).to eq([m5,m1,m4])
    end
  end
  describe 'instance methods' do
    it '.favorite_customer' do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant)
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      invoice = create_list(:invoice, 4, merchant: merchant, customer: customer_1, items: [item])
      invoice = create_list(:invoice, 1, merchant: merchant, customer: customer_2, items: [item])
      expect(merchant.favorite_customer).to eq(customer_1)
    end
    it '.total_revenue' do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant)
      invoice = create(:invoice, merchant: merchant)
      # transaction = create(:transaction, invoice: invoice)

      create_list(:invoice_item, 2, quantity: 2, unit_price: 200, item: item, invoice: invoice)
      create_list(:invoice_item, 1, quantity: 1, unit_price: 100, item: item, invoice: invoice)

      create_list(:invoice_item, 1, quantity: 1, unit_price: 100)
      expect(merchant.revenue).to eq(900)
    end
  end
end
