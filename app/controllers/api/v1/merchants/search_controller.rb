class Api::V1::Merchants::SearchController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.custom_where(merchant_params.to_h).limit(1).first)
  end
  def index
    render json: MerchantSerializer.new(Merchant.custom_where(merchant_params.to_h))
  end

  private

  def merchant_params
    params.permit(Merchant.attribute_names)
  end
end
