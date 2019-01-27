class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  def self.with_successful_invoices
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 0})
    .group("customers.id")
  end
  def favorite_merchant
    Merchant.joins(invoices: [:merchant, :transactions]).where(invoices: { customer_id: self.id } ).where(transactions: {result: 0}).group("merchants.id").order("count(invoices.id) DESC").limit(1).first
  end
end
