require "csv"
require './config/environment'

InvoiceItem.destroy_all
CSV.foreach('./db/invoice_items.csv', headers: true) do |row|
  InvoiceItem.create!(row.to_h)
end
