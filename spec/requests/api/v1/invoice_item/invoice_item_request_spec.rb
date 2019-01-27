require "rails_helper"

describe 'invoice_item requests' do
  it 'returns a list of all invoice_items' do
    merchant = create(:merchant)
    create_list(:invoice_item, 3)

    get '/api/v1/invoice_items'

    expect(response).to be_successful
    returned_invoice_items = JSON.parse(response.body)["data"]
    expect(returned_invoice_items.count).to eq(3)
  end
  it 'returns a specific invoice_item' do
    merchant = create(:merchant)
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{id}"

    expect(response).to be_successful
    returned_invoice_item = JSON.parse(response.body)["data"]
    expect(returned_invoice_item["id"]).to eq(id.to_s)
  end
  it "finds an invoice_item" do
    merchant = create(:merchant)
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/find?id=#{id}"

    expect(response).to be_successful
    returned_invoice_item = JSON.parse(response.body)["data"]
    expect(returned_invoice_item["id"]).to eq(id.to_s)
  end
  it "finds invoice_items" do
    merchant = create(:merchant)
    unit_price = 99
    invoice_item_1 = create(:invoice_item, unit_price: unit_price)
    invoice_item_2 = create(:invoice_item, unit_price: unit_price)
    invoice_item_3 = create(:invoice_item).id
    expected_ids = [invoice_item_1, invoice_item_2].map{|invoice_item| invoice_item.id.to_s}

    get "/api/v1/invoice_items/find_all?unit_price=#{unit_price}"

    expect(response).to be_successful
    returned_invoice_items = JSON.parse(response.body)["data"]
    returned_ids = returned_invoice_items.map{|invoice_item| invoice_item["id"]}

    expect(returned_ids).to eq(expected_ids)
  end
  it 'returns a random invoice_item' do
    invoice_item_1 = create(:invoice_item)
    invoice_item_2 = create(:invoice_item)

    get "/api/v1/invoice_items/random"

    expect(response).to be_successful
    returned_invoice_item = JSON.parse(response.body)["data"]
    expect(returned_invoice_item["type"]).to eq("invoice_item")
  end
end
