class Api::V1::Customers::RandomController < ApplicationController
  def show
    render json: CustomerSerializer.new(Customer.custom_sample)
  end
end
