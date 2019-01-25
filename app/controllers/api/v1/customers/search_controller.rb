class Api::V1::Customers::SearchController < ApplicationController
  def show
    attribute = (Customer.attribute_names & params.keys).first
    render json: CustomerSerializer.new(Customer.custom_where(attribute, params[attribute]).first)
  end
  def index
    attribute = (Customer.attribute_names & params.keys).first
    render json: CustomerSerializer.new(Customer.custom_where(attribute, params[attribute]))
  end
end
