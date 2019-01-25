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
      create_list(:invoice_item,1, item: @i1, quantity: 1)
      create_list(:invoice_item,5, item: @i2, quantity: 40)
      create_list(:invoice_item,20, item: @i3, quantity: 20)
      create_list(:invoice_item,1, item: @i4, quantity: 100)
      create_list(:invoice_item,1, item: @i5, quantity: 1)
    end
    it '.by_most_items' do
      expect(Item.by_most_items(3)).to eq([@i3, @i2, @i4])
    end
  end
end
