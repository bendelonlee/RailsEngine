require "csv"
require './config/environment'

Transaction.destroy_all
CSV.foreach('./db/transactions.csv', headers: true) do |row|
  Transaction.create!(row.to_h)
end
