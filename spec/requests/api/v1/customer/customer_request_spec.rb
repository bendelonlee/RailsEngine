require "rails_helper"

describe 'customer requests' do
  it 'returns a list of all customers' do
    merchant = create(:merchant)
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful
    returned_customers = JSON.parse(response.body)["data"]
    expect(returned_customers.count).to eq(3)
  end
  it 'returns a specific customer' do
    merchant = create(:merchant)
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    expect(response).to be_successful
    returned_customer = JSON.parse(response.body)["data"]
    expect(returned_customer["id"]).to eq(id.to_s)
  end
  it "finds an customer" do
    id = create(:customer).id

    get "/api/v1/customers/find?id=#{id}"

    expect(response).to be_successful
    returned_customer = JSON.parse(response.body)["data"]
    expect(returned_customer["id"]).to eq(id.to_s)
  end
  it "finds customers" do
    merchant = create(:merchant)
    first_name = "Isaac"
    customer_1 = create(:customer, first_name: first_name)
    customer_2 = create(:customer, first_name: first_name)
    customer_3 = create(:customer).id
    expected_ids = [customer_1, customer_2].map{|customer| customer.id.to_s}

    get "/api/v1/customers/find_all?first_name=#{first_name}"

    expect(response).to be_successful
    returned_customers = JSON.parse(response.body)["data"]
    returned_ids = returned_customers.map{|customer| customer["id"]}

    expect(returned_ids).to eq(expected_ids)
  end
end
