require "rails_helper"

describe 'item requests' do
  it 'returns a list of all items' do
    merchant = create(:merchant)
    create_list(:item, 3, merchant: merchant)

    get '/api/v1/items'

    expect(response).to be_successful
    returned_items = JSON.parse(response.body)
    expect(returned_items.count).to eq(3)
  end
  it 'returns a specific item' do
    merchant = create(:merchant)
    id = create(:item, merchant: merchant).id

    get "/api/v1/items/#{id}"

    expect(response).to be_successful
    returned_item = JSON.parse(response.body)
    expect(returned_item["id"]).to eq(id)

  end
end
