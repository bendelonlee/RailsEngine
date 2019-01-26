require "rails_helper"

describe 'invoice relationship requests' do
  it "returns the invoice's transactions" do
    invoice = create(:invoice)
    Transaction.destroy_all
    transactions = create_list(:transaction, 3, invoice: invoice)

    create(:transaction, invoice: create(:invoice))

    get "/api/v1/invoices/#{invoice.id}/transactions"
    expect(response).to be_successful

    returned_transactions = JSON.parse(response.body)["data"]
    expect(returned_transactions.count).to eq(3)

    expect(returned_transactions[0]["type"]).to eq("transaction")
  end
  it "returns the invoice's items" do
    invoice = create(:invoice)
    items = create_list(:item, 3, invoices: [invoice])

    create(:item, invoices: [create(:invoice)])

    get "/api/v1/invoices/#{invoice.id}/items"
    expect(response).to be_successful

    returned_items = JSON.parse(response.body)["data"]
    expect(returned_items.count).to eq(3)

    expect(returned_items[0]["type"]).to eq("item")
  end
  it "returns the invoice's invoice_items" do
    invoice = create(:invoice)
    invoice_items = create_list(:invoice_item, 3, invoice: invoice)

    create(:invoice_item, invoice: create(:invoice))

    get "/api/v1/invoices/#{invoice.id}/invoice_items"
    expect(response).to be_successful

    returned_invoice_items = JSON.parse(response.body)["data"]
    expect(returned_invoice_items.count).to eq(3)

    expect(returned_invoice_items[0]["type"]).to eq("invoice_item")
  end
  it "returns the invoice's customer" do
    invoice = create(:invoice)
    customer_1 = create(:customer, invoices: [invoice])

    create(:customer)

    get "/api/v1/invoices/#{invoice.id}/customer"
    expect(response).to be_successful

    returned_customers = JSON.parse(response.body)["data"]

    expect(returned_customers["type"]).to eq("customer")
    expect(returned_customers["id"]).to eq(customer_1.id.to_s)
  end
  it "returns the invoice's merchant" do
    invoice = create(:invoice)
    merchant_1 = create(:merchant, invoices: [invoice])

    create(:merchant)

    get "/api/v1/invoices/#{invoice.id}/merchant"
    expect(response).to be_successful

    returned_merchants = JSON.parse(response.body)["data"]

    expect(returned_merchants["type"]).to eq("merchant")
    expect(returned_merchants["id"]).to eq(merchant_1.id.to_s)
  end
end
