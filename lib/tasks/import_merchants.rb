require "csv"
require './config/environment'

Merchant.destroy_all
CSV.foreach('./db/merchants.csv', headers: true) do |row|
  Merchant.create!(row.to_h)
end
