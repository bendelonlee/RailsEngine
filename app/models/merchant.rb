class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.custom_where(attr, value)
    case attr
    when "name"
      where("upper(#{attr}) = ?", value.upcase)
    else
      where(attr => value)
    end
  end

  def self.merchants_with_invoice_items
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 0})
    .group("merchants.id")
  end


  def self.most_revenue(length)
    merchants_with_invoice_items
         .order("sum(invoice_items.unit_price * invoice_items.quantity) desc")
         .limit(length)
  end

  def self.merchants_by_most_items(length)
    merchants_with_invoice_items
         .order("sum(invoice_items.quantity) desc")
         .limit(length)
  end

  def favorite_customer
    Customer.with_invoice_items.joins(invoices: :merchant).where(merchants: {id: self.id} ).order("count(invoice_items) desc").limit(1).first
  end

  def revenue
    Merchant.merchants_with_invoice_items.where(id: self.id).select("merchants.id, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue").first.total_revenue
  end
end
