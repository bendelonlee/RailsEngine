require "rails_helper"

describe 'merchant requests' do
  it 'returns a list of all merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    returned_merchants = JSON.parse(response.body)["data"]
    expect(returned_merchants.count).to eq(3)
  end
  it 'returns a specific merchant' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    expect(response).to be_successful
    returned_merchant = JSON.parse(response.body)["data"]
    expect(returned_merchant["id"]).to eq(id.to_s)
  end
  it 'finds a specific merchant by attribute' do
    create_list(:merchant, 4)
    expected_merchant = Merchant.second

    get "/api/v1/merchants/find?name=#{expected_merchant.name}"

    returned_merchant = JSON.parse(response.body)
    expect(returned_merchant["id"]).to eq(expected_merchant.id)

    expected_merchant = Merchant.last
    expected_merchant.update(created_at: 5.days.ago)
    get "/api/v1/merchants/find?created_at=#{expected_merchant.created_at}"

    returned_merchant = JSON.parse(response.body)
    expect(returned_merchant["id"]).to eq(expected_merchant.id)

  end
end
