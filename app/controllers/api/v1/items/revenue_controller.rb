class Api::V1::Items::RevenueController < ApplicationController
  def index
    items = Item.by_most_revenue(params[:quantity])
    render json: ItemSerializer.new(items)
  end
end
