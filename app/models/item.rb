class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.items_with_successful_invoices
    Item.joins(:invoices).joins(invoices: :transactions).where(transactions: {result: 0})
  end

  def self.by_most_items(length)
    Item.items_with_successful_invoices.select("items.*, sum(invoice_items.quantity) as total_quantity").group(:id).order("total_quantity DESC").limit(length)
  end

  def best_day
    Item.items_with_successful_invoices.select("invoices.updated_at").group("invoices.updated_at").order("sum(invoice_items.quantity * invoice_items.unit_price) DESC, invoices.updated_at DESC").limit(1)[0].updated_at
  end

end
