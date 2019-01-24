class Api::V1::Merchants::SearchController < ApplicationController
  def show
    attribute = (Merchant.attribute_names & params.keys).first
    render json: MerchantSerializer.new(Merchant.custom_where(attribute, params[attribute]).first)
  end
  def index
    attribute = (Merchant.attribute_names & params.keys).first
    render json: MerchantSerializer.new(Merchant.custom_where(attribute, params[attribute]))
  end
end
