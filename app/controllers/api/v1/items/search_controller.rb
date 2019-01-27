class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: ItemSerializer.new(Item.custom_where(item_params.to_h).limit(1).first)
  end
  def index
    render json: ItemSerializer.new(Item.custom_where(item_params.to_h))
  end

  private

  def item_params
    params.permit(Item.attribute_names)
  end
end
