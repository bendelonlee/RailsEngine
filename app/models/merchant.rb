class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices


  def self.merchants_with_successful_invoices
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 0})
    .group("merchants.id")
  end

  def self.total_revene_from_date(date_string)
    date = Date.parse(date_string)
    date_range = date.beginning_of_day.. date.end_of_day
    merchants_with_successful_invoices.where(invoices: {updated_at: date_range}).unscope(:group).sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def self.most_revenue(length)
    merchants_with_successful_invoices
         .order("sum(invoice_items.unit_price * invoice_items.quantity) desc")
         .limit(length)
  end

  def self.merchants_by_most_items(length)
    merchants_with_successful_invoices
         .order("sum(invoice_items.quantity) desc")
         .limit(length)
  end

  def revenue_from_date(date_string)
    date = Date.parse(date_string)
    date_range = date.beginning_of_day.. date.end_of_day
    Merchant.merchants_with_successful_invoices.where(invoices: {updated_at: date_range}, id: self.id).unscope(:group).sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def favorite_customer
    Customer.with_successful_invoices
      .joins(invoices: :merchant)
      .where(merchants: {id: self.id} )
      .order("count(invoice_items) desc").limit(1).first
  end

  def revenue
    Merchant.merchants_with_successful_invoices.where(id: self.id).select("merchants.id, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue").first.total_revenue
  end
end
