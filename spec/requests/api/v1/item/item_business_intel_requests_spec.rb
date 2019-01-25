require "rails_helper"

describe 'item business intelligence requests' do
  describe 'involving all items' do
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
  describe 'involving one item' do
    it 'returns an items best day by items sold' do
      date_1 = 5.days.ago
      date_2 = 3.days.ago
      item_1 = create(:item)
      invoice_1 = create(:invoice, created_at: 5.days.ago, updated_at: date_1)
      invoice_2 = create(:invoice, created_at: 5.days.ago, updated_at: date_2)
      create_list(:invoice_item,4, item: item_1, quantity: 1, invoice: invoice_2)
      create_list(:invoice_item,1, item: item_1, quantity: 4, invoice: invoice_1)
      create_list(:invoice_item,1, item: item_1, quantity: 3)

      get "/api/v1/items/#{item_1.id}/best_day"
      expect(response).to be_successful
      returned_item = JSON.parse(response.body)["data"]
      expect(returned_item["attributes"]["best_day"]).to eq(date_2.utc.iso8601(3))
    end
  end
end
