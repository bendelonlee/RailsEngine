class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  def self.most_revenue(length)
    merchants_with_invoice_items
         .order("sum(invoice_items.unit_price * invoice_items.quantity) desc")
         .limit(length)
  end

  def self.merchants_with_invoice_items
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 0})
    .group(:id)
  end

  def revenue
    Merchant.merchants_with_invoice_items.where(id: self.id).select("merchants.id, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue").first.total_revenue
  end
end
