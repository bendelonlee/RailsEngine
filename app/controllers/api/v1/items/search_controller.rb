class Api::V1::Merchants::SearchController < ApplicationController
  def show
    attribute = (Item.attribute_names & params.keys).first
    render json: MerchantSerializer.new(Item.custom_where(attribute, params[attribute]).first)
  end
  def index
    attribute = (Item.attribute_names & params.keys).first
    render json: MerchantSerializer.new(Item.custom_where(attribute, params[attribute]))
  end
end
