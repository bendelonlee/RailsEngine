class Api::V1::Merchants::RevenueByDateController < ApplicationController
  def index
    revenue_from_date = Merchant.total_revene_from_date(params[:date])
    rev = Struct.new(:id, :total_revenue)
    render json: TotalRevenueSerializer.new(rev.new(0, revenue_from_date))
  end
end
