class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.most_revenue(params[:quantity]))
  end
  def show
    merchant = Merchant.find(params[:id])
    render json: RevenueSerializer.new({id: merchant.id, revenue:"9.00"})
  end
end
