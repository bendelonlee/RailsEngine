require "rails_helper"

describe 'item relationship requests' do
  it "returns the item's invoice_items" do
    item = create(:item)
    invoice_items = create_list(:invoice_item, 3, item: item)

    create(:invoice_item, item: create(:item))

    get "/api/v1/items/#{item.id}/invoice_items"
    expect(response).to be_successful

    returned_invoice_items = JSON.parse(response.body)["data"]
    expect(returned_invoice_items.count).to eq(3)

    expect(returned_invoice_items[0]["type"]).to eq("invoice_item")
  end
  it "returns the item's merchant" do
    item = create(:item)
    merchant_1 = create(:merchant, items: [item])

    create(:merchant)

    get "/api/v1/items/#{item.id}/merchant"
    expect(response).to be_successful

    returned_merchant = JSON.parse(response.body)["data"]

    expect(returned_merchant["type"]).to eq("merchant")
    expect(returned_merchant["id"]).to eq(merchant_1.id.to_s)
  end
end
