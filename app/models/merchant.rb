class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices


  def self.with_successful_invoices
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 0})
    .group("merchants.id")
  end

  def self.total_revene_from_date(date_string)
    date = Date.parse(date_string)
    date_range = date.beginning_of_day.. date.end_of_day
    with_successful_invoices.where(invoices: {updated_at: date_range}).unscope(:group).sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def self.most_revenue(length)
    with_successful_invoices
         .order("sum(invoice_items.unit_price * invoice_items.quantity) desc")
         .limit(length)
  end

  def self.merchants_by_most_items(length)
    with_successful_invoices
         .order("sum(invoice_items.quantity) desc")
         .limit(length)
  end

  def revenue_from_date(date_string)
    date = Date.parse(date_string)
    date_range = date.beginning_of_day.. date.end_of_day
    Merchant.with_successful_invoices.where(invoices: {updated_at: date_range}, id: self.id).unscope(:group).sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def favorite_customer
    Customer.with_successful_invoices
      .joins(invoices: :merchant)
      .where(invoices: {merchant_id: self.id})
      .order("count(invoice_items) desc").limit(1).first
  end

  def revenue
    Merchant.with_successful_invoices.where(id: self.id).select("merchants.id, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue").first.total_revenue
  end

  def customers_with_pending_invoices
    Customer.find_by_sql(["SELECT c.*
                            FROM customers c
                            INNER JOIN invoices i
                            ON c.id = i.customer_id
                            INNER JOIN transactions t
                            ON i.id = t.invoice_id
                            WHERE t.result = 1
                            AND i.merchant_id = ?
                          EXCEPT
                          SELECT c.*
                            FROM customers c
                            INNER JOIN invoices i
                            ON c.id = i.customer_id
                            INNER JOIN transactions t
                            ON i.id = t.invoice_id
                            WHERE t.result = 0
                            AND i.merchant_id = ?", self.id, self.id])
  end
end
