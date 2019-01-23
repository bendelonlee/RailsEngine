require "rails_helper"

describe 'AllMerchant business intelligence endpoints' do
  it 'returns top x merchants ranked by revenue' do
    m1, m2, m3, m4, m5 = create_list(:merchant, 5)

    item_4 = create(:item, merchant: m5)
    item_3 = create(:item,  merchant: m1)
    item_2 = create(:item, merchant: m4)
    item_1 = create(:item,  merchant: m2)
    item_0 = create(:item,  merchant: m3)

    invoice_4 = create(:invoice, merchant: m5)
    invoice_3 = create(:invoice,  merchant: m1)
    invoice_2 = create(:invoice, merchant: m4)
    invoice_1 = create(:invoice,  merchant: m2)
    invoice_0 = create(:invoice,  merchant: m3)

    create_list(:invoice_item, 5, quantity: 2, item: item_4, unit_price: 1000, invoice: invoice_4)
    create_list(:invoice_item, 1, quantity: 2, item: item_3, unit_price: 2000, invoice: invoice_3)
    create_list(:invoice_item, 2, quantity: 4, item: item_2, unit_price: 100, invoice: invoice_2)
    create_list(:invoice_item, 1, quantity: 14, item: item_1, unit_price: 10, invoice: invoice_1)

    get "/api/v1/merchants/most_revenue?quantity=#{4}"
    
  end
end
