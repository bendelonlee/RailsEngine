class Api::V1::Customers::SearchController < ApplicationController
  def show
    customer = Customer.custom_where(customer_params.to_h).limit(1).first
    render json: CustomerSerializer.new(customer)
  end
  def index
    customer = Customer.custom_where(customer_params.to_h)
    render json: CustomerSerializer.new(customer)
  end

  private

  def customer_params
    params.permit(Customer.attribute_names)
  end
end
