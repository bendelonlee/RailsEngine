require "rails_helper"
describe 'customer intelligence' do
  it "returns a customer's favorite merchant" do
    customer = create(:customer)
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_2)

    invoice = create_list(:invoice, 4, customer: customer, merchant: merchant_1, items: [item_1])
    invoice = create_list(:invoice, 1, customer: customer, merchant: merchant_2, items: [item_2])

    get "/api/v1/customers/#{customer.id}/favorite_merchant"
    expect(response).to be_successful
    returned_merchant = JSON.parse(response.body)["data"]
    expect(returned_merchant["id"]).to eq(merchant_1.id.to_s)
  end
end
