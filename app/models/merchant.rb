class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  def self.most_revenue(length)
    joins(invoices: :invoice_items)
         .group(:id)
         .order("sum(invoice_items.unit_price * invoice_items.quantity) desc")
         .limit(length)
  end
end
