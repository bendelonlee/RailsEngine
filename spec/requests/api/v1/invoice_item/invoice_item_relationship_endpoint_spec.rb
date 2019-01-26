require "rails_helper"

describe 'invoice_item relationship requests' do
  it "returns the invoice_item's item" do
    invoice_item = create(:invoice_item)
    item_1 = create(:item, invoice_items: [invoice_item])

    create(:item)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"
    expect(response).to be_successful

    returned_items = JSON.parse(response.body)["data"]

    expect(returned_items["type"]).to eq("item")
    expect(returned_items["id"]).to eq(item_1.id.to_s)
  end
  it "returns the invoice_item's invoice" do
    invoice_item = create(:invoice_item)
    invoice_1 = create(:invoice, invoice_items: [invoice_item])

    create(:invoice)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"
    expect(response).to be_successful

    returned_invoices = JSON.parse(response.body)["data"]

    expect(returned_invoices["type"]).to eq("invoice")
    expect(returned_invoices["id"]).to eq(invoice_1.id.to_s)
  end
end
