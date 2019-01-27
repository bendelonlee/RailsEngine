class Api::V1::Invoices::RandomController < ApplicationController
  def show
    render json: InvoiceSerializer.new(Invoice.custom_sample)
  end
end
