require "rails_helper"

describe 'transaction requests' do
  it 'returns a list of all transactions' do
    create_list(:invoice, 3)

    get '/api/v1/transactions'

    expect(response).to be_successful
    returned_transactions = JSON.parse(response.body)["data"]
    expect(returned_transactions.count).to eq(3)
  end
  it 'returns a specific transaction' do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}"

    expect(response).to be_successful
    returned_transaction = JSON.parse(response.body)["data"]
    expect(returned_transaction["id"]).to eq(id.to_s)
  end
  it "finds an transaction" do
    id = create(:transaction).id

    get "/api/v1/transactions/find?id=#{id}"

    expect(response).to be_successful
    returned_transaction = JSON.parse(response.body)["data"]
    expect(returned_transaction["id"]).to eq(id.to_s)
  end
  it "finds transactions" do
    credit_card_number = 99
    transaction_1 = create(:transaction, credit_card_number: credit_card_number)
    transaction_2 = create(:transaction, credit_card_number: credit_card_number)
    transaction_3 = create(:transaction).id
    expected_ids = [transaction_1, transaction_2].map{|transaction| transaction.id.to_s}

    get "/api/v1/transactions/find_all?credit_card_number=#{credit_card_number}"

    expect(response).to be_successful
    returned_transactions = JSON.parse(response.body)["data"]
    returned_ids = returned_transactions.map{|transaction| transaction["id"]}

    expect(returned_ids).to eq(expected_ids)
  end
  it 'returns a random transaction' do
    transaction_1 = create(:transaction)
    transaction_2 = create(:transaction)

    get "/api/v1/transactions/random"

    expect(response).to be_successful
    returned_transaction = JSON.parse(response.body)["data"]
    expect(returned_transaction["type"]).to eq("transaction")
  end
end
