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

    returned_merchant = JSON.parse(response.body)["data"]
    expect(returned_merchant["id"]).to eq(expected_merchant.id.to_s)

    expected_merchant = Merchant.last
    created_at = "2012-03-26 14:58:14 UTC"
    expected_merchant.update(created_at: created_at)
    get "/api/v1/merchants/find?created_at=#{created_at}"

    returned_merchant = JSON.parse(response.body)["data"]
    expect(returned_merchant["id"]).to eq(expected_merchant.id.to_s)

    expected_merchant = Merchant.first
    get "/api/v1/merchants/find?id=#{expected_merchant.id}"

    returned_merchant = JSON.parse(response.body)["data"]
    expect(returned_merchant["id"]).to eq(expected_merchant.id.to_s)
  end
  describe 'finds a group of merchants by attribute' do
    before(:each) do
      create_list(:merchant, 9)
      num_merchants = rand(1..5)
      @expected_merchants = Merchant.limit(num_merchants)
      @expected_ids = @expected_merchants.pluck(:id).map(&:to_s)
    end
    it 'finds all by name' do
      @attribute = {name: "Jerry"}
    end
    it 'finds all by updated_at' do
      @attribute = {updated_at: '2012-03-27 14:54:09 UTC'}
    end
    after(:each) do
      @expected_merchants.update(name: @attribute[:name])
      attr_name = @attribute.keys[0]
      get "/api/v1/merchants/find_all?#{attr_name}=#{@attribute[attr_name]}"
      returned_merchants = JSON.parse(response.body)["data"]
      returned_ids = returned_merchants.map{|m| m["id"]}
      expect(returned_ids).to eq(@expected_ids)
    end
  end
end
