class Api::V1::Customers::SearchController < ApplicationController
  def show
    render json: CustomerSerializer.new(Customer.custom_where(customer_params.to_h).first)
  end
  def index
    render json: CustomerSerializer.new(Customer.custom_where(customer_params.to_h))
  end

  private

  def customer_params
    params.permit(Customer.attribute_names)
  end
end
