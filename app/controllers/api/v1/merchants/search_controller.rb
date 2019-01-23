class Api::V1::Merchants::SearchController < ApplicationController
  def show
    attribute = (Merchant.attribute_names & params.keys).first
    case attribute
    when "created_at", "updated_at"
      date = Date.parse(params[attribute])
      time_range = date.beginning_of_day .. date.end_of_day
      render json: MerchantSerializer.new(Merchant.where(attribute => time_range).first)
    else
      render json: MerchantSerializer.new(Merchant.find_by(attribute => params[attribute]))
    end
  end
end
