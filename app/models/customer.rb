class Customer < ApplicationRecord
  has_many :invoices
  def self.with_invoice_items
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 0})
    .group("customers.id")
  end
end
