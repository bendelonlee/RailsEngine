require "rails_helper"

describe 'merchant relationship requests' do
  it "returns the merchant's items" do
    merchant = create(:merchant)
    items = create_list(:item, 3, merchant: merchant)

    create(:item, merchant: create(:merchant))

    get "/api/v1/merchants/#{merchant.id}/items"
    expect(response).to be_successful

    returned_items = JSON.parse(response.body)["data"]
    expect(returned_items.count).to eq(3)

    expect(returned_items[0]["type"]).to eq("item")
  end
  it "returns the merchant's invoices" do
    merchant = create(:merchant)
    invoices = create_list(:invoice, 3, merchant: merchant)

    create(:invoice, merchant: create(:merchant))

    get "/api/v1/merchants/#{merchant.id}/invoices"
    expect(response).to be_successful

    returned_invoices = JSON.parse(response.body)["data"]
    expect(returned_invoices.count).to eq(3)

    expect(returned_invoices[0]["type"]).to eq("invoice")
  end
end
