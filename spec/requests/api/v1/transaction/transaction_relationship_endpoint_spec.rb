require "rails_helper"

describe 'transaction relationship requests' do

  it "returns the transaction's invoice" do
    transaction = create(:transaction)
    invoice_1 = create(:invoice, transactions: [transaction])

    create(:invoice)

    get "/api/v1/transactions/#{transaction.id}/invoice"
    expect(response).to be_successful

    returned_invoice = JSON.parse(response.body)["data"]

    expect(returned_invoice["type"]).to eq("invoice")
    expect(returned_invoice["id"]).to eq(invoice_1.id.to_s)
  end
end
