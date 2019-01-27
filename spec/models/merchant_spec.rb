require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoices) }
  end
  describe "class methods" do
    before(:each) do
      @m1, @m2, @m3, @m4, @m5 = create_list(:merchant, 5)
      @date = "2012-03-09 01:54:10 UTC"

      item_4 = create(:item, merchant: @m5)
      item_3 = create(:item,  merchant: @m1)
      item_2 = create(:item, merchant: @m4)
      item_1 = create(:item,  merchant: @m2)
      item_0 = create(:item,  merchant: @m3)

      invoice_4 = create(:invoice, merchant: @m5 )
      invoice_3 = create(:invoice,  merchant: @m1 )
      invoice_2 = create(:invoice, merchant: @m4, updated_at: @date)
      invoice_1 = create(:invoice,  merchant: @m2, updated_at: @date)
      invoice_0 = create(:invoice,  merchant: @m3, updated_at: @date)

      create_list(:invoice_item, 5, quantity: 2, item: item_4, unit_price: 1000, invoice: invoice_4)
      create_list(:invoice_item, 1, quantity: 2, item: item_3, unit_price: 2000, invoice: invoice_3)
      create_list(:invoice_item, 2, quantity: 4, item: item_2, unit_price: 100, invoice: invoice_2)
      create_list(:invoice_item, 1, quantity: 14, item: item_1, unit_price: 10, invoice: invoice_1)
    end
    it '.most_revenue' do
      expect(Merchant.most_revenue(3)).to eq([@m5,@m1,@m4])
    end
    it '.merchants_by_most_items' do
      expect(Merchant.merchants_by_most_items(3)).to eq([@m2,@m5,@m4])
    end
    it 'total_revene_from_date' do
      expect(Merchant.total_revene_from_date(@date.to_s)).to eq(940)
    end
  end
  describe 'instance methods' do
    it 'revenue_from_date' do
      @m1 = create(:merchant,)
      @date = "2012-03-09 01:54:10 UTC"

      item_4 = create(:item, merchant: @m1)
      item_3 = create(:item,  merchant: @m1)
      item_2 = create(:item, merchant: @m1)
      item_1 = create(:item,  merchant: @m1)
      item_0 = create(:item,  merchant: @m1)

      invoice_4 = create(:invoice, merchant: @m1 )
      invoice_3 = create(:invoice,  merchant: @m1 )
      invoice_2 = create(:invoice, merchant: @m1, updated_at: @date)
      invoice_1 = create(:invoice,  merchant: @m1, updated_at: @date)
      invoice_0 = create(:invoice,  merchant: @m1, updated_at: @date)

      create_list(:invoice_item, 5, quantity: 2, item: item_4, unit_price: 1000, invoice: invoice_4)
      create_list(:invoice_item, 1, quantity: 2, item: item_3, unit_price: 2000, invoice: invoice_3)
      create_list(:invoice_item, 2, quantity: 4, item: item_2, unit_price: 100, invoice: invoice_2)
      create_list(:invoice_item, 1, quantity: 14, item: item_1, unit_price: 10, invoice: invoice_1)

      expect(@m1.revenue_from_date(@date.to_s)).to eq(940)
    end
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
    it '.customers_with_pending_invoices' do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant)
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      customer_3 = create(:customer)
      invoice_1 = create(:invoice, merchant: merchant, customer: customer_1, items: [item])
      invoice_2 = create(:invoice, merchant: merchant, customer: customer_2, items: [item])
      invoice_3 = create(:invoice, merchant: merchant, customer: customer_3, items: [item])

      create(:transaction, invoice: invoice_1, result: :failed)
      invoice_2.transactions.update(result: :failed)
      actual = merchant.customers_with_pending_invoices
      expect(actual.size).to eq(1)
      expect(actual.first).to eq(customer_2)
    end
  end
end
