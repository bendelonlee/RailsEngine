require "rails_helper"

describe 'invoice relationship requests' do
  it 'returns the invoices transactions' do
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
  it 'returns the invoices items' do
    invoice = create(:invoice)
    items = create_list(:item, 3, invoices: [invoice])

    create(:item, invoices: [create(:invoice)])

    get "/api/v1/invoices/#{invoice.id}/items"
    expect(response).to be_successful

    returned_items = JSON.parse(response.body)["data"]
    expect(returned_items.count).to eq(3)

    expect(returned_items[0]["type"]).to eq("item")
  end
end
