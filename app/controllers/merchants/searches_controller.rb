class Merchants::SearchesController < ApplicationController
  def show
    attribute = (Merchant.attribute_names & params.keys).first
    render json: Merchant.find_by(attribute => params[attribute])
  end
end
