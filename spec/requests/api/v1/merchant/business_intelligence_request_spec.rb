require "rails_helper"

describe 'Merchant business intelligence endpoints for all merchants' do
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
  it 'returns top x merchants ranked by revenue' do
    get "/api/v1/merchants/most_revenue?quantity=#{4}"
    expect(response).to be_successful
    returned_merchants = JSON.parse(response.body)["data"]
    expect(returned_merchants.count).to eq(4)
    expect(returned_merchants.first["id"]).to eq(@m5.id.to_s)
    expect(returned_merchants.second["id"]).to eq(@m1.id.to_s)
    expect(returned_merchants.third["id"]).to eq(@m4.id.to_s)
    expect(returned_merchants.last["id"]).to eq(@m2.id.to_s)
  end
  it 'returns top x merchants ranked by total items sold' do
    get "/api/v1/merchants/most_items?quantity=#{3}"
    expect(response).to be_successful
    returned_merchants = JSON.parse(response.body)["data"]
    expect(returned_merchants.count).to eq(3)
    expect(returned_merchants.first["id"]).to eq(@m2.id.to_s)
    expect(returned_merchants.second["id"]).to eq(@m5.id.to_s)
    expect(returned_merchants.third["id"]).to eq(@m4.id.to_s)
  end
  it 'returns revenue across all merchants for a given date' do
    get "/api/v1/merchants/revenue?date=#{@date}"
    expect(response).to be_successful
    returned_revenue = JSON.parse(response.body)["data"]["attributes"]["total_revenue"]
    expect(returned_revenue).to eq "9.40"
  end
end

describe 'Merchant business intelligence endpoints for individual merchants' do
  it "returns a merchant's revenue" do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, merchant: merchant)
    # transaction = create(:transaction, invoice: invoice)

    create_list(:invoice_item, 2, quantity: 2, unit_price: 200, item: item, invoice: invoice)
    create_list(:invoice_item, 1, quantity: 1, unit_price: 100, item: item, invoice: invoice)

    create_list(:invoice_item, 1, quantity: 1, unit_price: 100)
    get "/api/v1/merchants/#{merchant.id}/revenue"
    expect(response).to be_successful
    returned_revenue = JSON.parse(response.body)["data"]["attributes"]["revenue"]
    expect(returned_revenue).to eq "9.00"
  end

  it 'returns a merchants revenue by date' do
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

    get "/api/v1/merchants/#{@m1.id}/revenue?date=#{@date}"
    expect(response).to be_successful
    returned_revenue = JSON.parse(response.body)["data"]["attributes"]["revenue"]
    expect(returned_revenue).to eq "9.40"
  end

  it 'returns a merchants favorite customer' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)
    customer_1 = create(:customer)
    customer_2 = create(:customer)
    invoice = create_list(:invoice, 4, merchant: merchant, customer: customer_1, items: [item])
    invoice = create_list(:invoice, 1, merchant: merchant, customer: customer_2, items: [item])

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"
    expect(response).to be_successful
    returned_customer = JSON.parse(response.body)["data"]
    expect(returned_customer["id"]).to eq(customer_1.id.to_s)
  end
end
