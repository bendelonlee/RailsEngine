require "rails_helper"

describe 'ApplicationRecord custom methods' do
  it ".custom_where" do
    create_list(:item, 5)
    merchant = create(:merchant)
    find_item = {
      "id" => 100,
      "name" => "sauce",
      "description" => "special",
      "unit_price" => "100000",
      "created_at" => "2012-03-16",
      "updated_at" => "2012-03-16",
      "merchant_id" => merchant.id
    }
    item = Item.create!(find_item)
    find_item["name"] = "SaUCe"
    find_item["unit_price"] = "1000.00"
    find_item.each do |attr, value|
      actual = Item.custom_where( { attr => value } )
      expect(actual.size).to eq(1)
      expect(actual.first).to eq(item)
    end
  end
  it ".custom_sample" do
    create_list(:merchant, 5)
    expect(Merchant.custom_sample).to be_a(Merchant)
    expect(Customer.custom_sample).to be_nil
  end
end
