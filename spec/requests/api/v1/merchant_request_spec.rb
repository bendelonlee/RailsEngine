require "rails_helper"

describe 'merchant requests' do
  it 'returns a list of all merchants' do
    create_list(:merchant, 3)

    get '/merchants'

    expect(response).to be_successful
    returned_merchants = JSON.parse(response.body)
    expect(returned_merchants.count).to eq(3)
  end
  it 'returns a specific merchant' do
    create_list(:merchant, 3)
    id = create(:merchant).id

    get "/merchants/#{id}"

    expect(response).to be_successful
    returned_merchant = JSON.parse(response.body)
    expect(returned_merchant["id"]).to eq(id)

    expected_merchant = Merchant.first

    get "/merchants/find?name=#{expected_merchant.name}"

    returned_merchant = JSON.parse(response.body)
    expect(returned_merchant["id"]).to eq(expected_merchant.id)

  end
end
