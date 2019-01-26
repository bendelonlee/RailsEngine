class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  def self.with_successful_invoices
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 0})
    .group("customers.id")
  end
end
