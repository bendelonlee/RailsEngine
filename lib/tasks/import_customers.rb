require "csv"
require './config/environment'

Customer.destroy_all
CSV.foreach('./db/customers.csv', headers: true) do |row|
  Customer.create!(row.to_h)
end
