require "csv"
require './config/environment'

Item.destroy_all
CSV.foreach('./db/items.csv', headers: true) do |row|
  Item.create!(row.to_h)
end
