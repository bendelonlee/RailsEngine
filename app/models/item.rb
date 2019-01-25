class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.by_most_items(length)
    Item.select("items.*, sum(invoice_items.quantity) as total_quantity").joins(invoices: :transactions).where(transactions: {result: 0}).group(:id).order("total_quantity DESC").limit(length)
  end
end
