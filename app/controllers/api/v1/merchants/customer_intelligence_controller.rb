class Api::V1::Merchants::CustomerIntelligenceController < ApplicationController
  def show
    customer = Merchant.find(params[:id]).favorite_customer
    render json: CustomerSerializer.new(customer)
  end
end
