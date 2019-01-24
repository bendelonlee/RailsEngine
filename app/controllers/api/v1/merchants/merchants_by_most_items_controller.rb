class Api::V1::Merchants::MerchantsByMostItemsController < ApplicationController
  def index
    merchants = Merchant.merchants_by_most_items(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end
end
