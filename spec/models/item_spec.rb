require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many :invoices }
  end
  describe 'class methods' do
    before(:each) do
      @i1, @i2, @i3, @i4, @i5 = create_list(:item, 5)
      create_list(:invoice_item,1, item: @i1, quantity: 1, unit_price: 10000)
      create_list(:invoice_item,5, item: @i2, quantity: 40, unit_price: 1)
      create_list(:invoice_item,20, item: @i3, quantity: 20, unit_price: 1)
      create_list(:invoice_item,1, item: @i4, quantity: 100, unit_price: 10)
      create_list(:invoice_item,1, item: @i5, quantity: 1, unit_price: 20000)
    end
    it '.by_most_items' do
      expect(Item.by_most_items(3)).to eq([@i3, @i2, @i4])
    end
    it '.by_most_revenue' do
      expect(Item.by_most_revenue(3)).to eq([@i5, @i1, @i4])
    end
  end
  describe 'instance methods' do
    it 'best_day' do
      date_1 = 5.days.ago
      date_2 = 3.days.ago
      item_1 = create(:item)
      invoice_1 = create(:invoice, created_at: 5.days.ago, updated_at: date_1)
      invoice_2 = create(:invoice, created_at: 5.days.ago, updated_at: date_2)
      create_list(:invoice_item,4, item: item_1, quantity: 1, invoice: invoice_2)
      create_list(:invoice_item,1, item: item_1, quantity: 4, invoice: invoice_1)
      create_list(:invoice_item,1, item: item_1, quantity: 3)

      expect(item_1.best_day).to eq(date_2)
    end
  end
end
