class Api::V1::Items::QuantityController < ApplicationController
  def index
    items = Item.by_most_items(params[:quantity])
    render json: ItemSerializer.new(items)
  end
end
