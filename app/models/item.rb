class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.by_most_items(length)
    Item.select("items.*, sum(invoice_items.quantity)").joins(invoices: :transactions).where()
  end
end
