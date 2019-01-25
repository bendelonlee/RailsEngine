require "rails_helper"

describe 'invoice requests' do
  it 'returns a list of all invoices' do
    merchant = create(:merchant)
    create_list(:invoice, 3, merchant: merchant)

    get '/api/v1/invoices'

    expect(response).to be_successful
    returned_invoices = JSON.parse(response.body)["data"]
    expect(returned_invoices.count).to eq(3)
  end
  it 'returns a specific invoice' do
    merchant = create(:merchant)
    id = create(:invoice, merchant: merchant).id

    get "/api/v1/invoices/#{id}"

    expect(response).to be_successful
    returned_invoice = JSON.parse(response.body)["data"]
    expect(returned_invoice["id"]).to eq(id.to_s)
  end
  it "finds an invoice" do
    merchant = create(:merchant)
    id = create(:invoice, merchant: merchant).id

    get "/api/v1/invoices/find?id=#{id}"

    expect(response).to be_successful
    returned_invoice = JSON.parse(response.body)["data"]
    expect(returned_invoice["id"]).to eq(id.to_s)
  end
  it "finds invoices" do
    merchant = create(:merchant)
    status = "shipped"
    invoice_1 = create(:invoice, merchant: merchant, status: status)
    invoice_2 = create(:invoice, merchant: merchant, status: status)
    invoice_3 = create(:invoice, merchant: merchant, status: "unshipped").id
    expected_ids = [invoice_1, invoice_2].map{|invoice| invoice.id.to_s}

    get "/api/v1/invoices/find_all?status=#{status}"

    expect(response).to be_successful
    returned_invoices = JSON.parse(response.body)["data"]
    returned_ids = returned_invoices.map{|invoice| invoice["id"]}

    expect(returned_ids).to eq(expected_ids)
  end
end
