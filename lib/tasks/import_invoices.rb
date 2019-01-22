require "csv"
require './config/environment'

Invoice.destroy_all
CSV.foreach('./db/invoices.csv', headers: true) do |row|
  Invoice.create!(row.to_h)
end
