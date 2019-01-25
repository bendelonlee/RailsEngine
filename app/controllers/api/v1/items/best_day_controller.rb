class Api::V1::Items::BestDayController < ApplicationController
  def show
    item = Item.find(params[:id])
    render json: BestDaySerializer.new(item)
  end
end
