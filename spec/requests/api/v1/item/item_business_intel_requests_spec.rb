require "rails_helper"

describe 'item business intelligence requests' do
  before(:each) do
    @i1, @i2, @i3, @i4, @i5 = create_list(:item, 5)
    create_list(:invoice_item,1, item: @i1, quantity: 1)
    create_list(:invoice_item,5, item: @i2, quantity: 40)
    create_list(:invoice_item,20, item: @i3, quantity: 20)
    create_list(:invoice_item,1, item: @i4, quantity: 100)
    create_list(:invoice_item,1, item: @i5, quantity: 1)
  end
  it 'returns the top items by quanitity sold' do
    get "/api/v1/items/most_items?quantity=#{3}"
    expect(response).to be_successful
    returned_items = JSON.parse(response.body)["data"]
    expect(returned_items.count).to eq(3)
    expect(returned_items.first["id"]).to eq(@i3.id.to_s)
    expect(returned_items.second["id"]).to eq(@i2.id.to_s)
    expect(returned_items.third["id"]).to eq(@i4.id.to_s)
  end
end
