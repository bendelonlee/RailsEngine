require "rails_helper"

describe 'merchant relationship requests' do
  it 'items' do
    merchant = create(:merchant)
    items = create_list(:item, 3, merchant: merchant)

    create(:item, merchant: create(:merchant))

    get "/api/v1/merchants/#{merchant.id}/items"
    expect(response).to be_successful
    items = JSON.parse(response.body)#["data"]
    expect(items.count).to eq(3)
  end
end
