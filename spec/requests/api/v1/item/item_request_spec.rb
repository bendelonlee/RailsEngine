require "rails_helper"

describe 'item requests' do
  it 'returns a list of all items' do
    merchant = create(:merchant)
    create_list(:item, 3, merchant: merchant)

    get '/api/v1/items'

    expect(response).to be_successful
    returned_items = JSON.parse(response.body)["data"]
    expect(returned_items.count).to eq(3)
  end
  it 'returns a specific item' do
    merchant = create(:merchant)
    id = create(:item, merchant: merchant).id

    get "/api/v1/items/#{id}"

    expect(response).to be_successful
    returned_item = JSON.parse(response.body)["data"]
    expect(returned_item["id"]).to eq(id.to_s)
  end
  it "finds an item" do
    merchant = create(:merchant)
    id = create(:item, merchant: merchant).id

    get "/api/v1/items/find?id=#{id}"

    expect(response).to be_successful
    returned_item = JSON.parse(response.body)["data"]
    expect(returned_item["id"]).to eq(id.to_s)
  end
  it "finds items" do
    merchant = create(:merchant)
    unit_price = 99
    item_1 = create(:item, merchant: merchant, unit_price: unit_price)
    item_2 = create(:item, merchant: merchant, unit_price: unit_price)
    item_3 = create(:item, merchant: merchant).id
    expected_ids = [item_1, item_2].map{|item| item.id.to_s}

    get "/api/v1/items/find_all?unit_price=#{unit_price}"

    expect(response).to be_successful
    returned_items = JSON.parse(response.body)["data"]
    returned_ids = returned_items.map{|item| item["id"]}

    expect(returned_ids).to eq(expected_ids)
  end
end
