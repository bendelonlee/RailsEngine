require "rails_helper"

describe 'customer relationship requests' do
  it 'returns the customers invoices' do
    customer = create(:customer)
    invoices = create_list(:invoice, 3, customer: customer)

    create(:invoice, customer: create(:customer))

    get "/api/v1/customers/#{customer.id}/invoices"
    expect(response).to be_successful

    returned_invoices = JSON.parse(response.body)["data"]
    expect(returned_invoices.count).to eq(3)

    expect(returned_invoices[0]["type"]).to eq("invoice")
  end
  it 'returns the customers transactions' do
    invoice = create(:invoice)
    Transaction.destroy_all
    customer = invoice.customer
    transactions = create_list(:transaction, 3, invoice: invoice)

    create(:transaction, invoice: create(:invoice))

    get "/api/v1/customers/#{customer.id}/transactions"
    expect(response).to be_successful

    returned_transactions = JSON.parse(response.body)["data"]
    expect(returned_transactions.count).to eq(3)

    expect(returned_transactions[0]["type"]).to eq("transaction")
  end
end
