class Api::V1::Merchants::RevenueByDateController < ApplicationController
  def index
    revenue_from_date = Merchant.total_revene_from_date(params[:date])
    rev = Struct.new(:id, :total_revenue)
    render json: TotalRevenueSerializer.new(rev.new(0, revenue_from_date))
  end
  def show
    merchant = Merchant.find(params[:id])
    revenue_from_date = merchant.revenue_from_date(params[:date])
    rev = Struct.new(:id, :revenue)
    render json: RevenueSerializer.new(rev.new(0, revenue_from_date))
  end
end
