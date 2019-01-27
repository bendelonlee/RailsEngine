class Api::V1::InvoiceItems::RandomController < ApplicationController
  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.custom_sample)
  end
end
