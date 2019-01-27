class Api::V1::Invoices::SearchController < ApplicationController
  def show
    render json: InvoiceSerializer.new(Invoice.custom_where(invoice_params.to_h).limit(1).first)
  end
  def index
    render json: InvoiceSerializer.new(Invoice.custom_where(invoice_params.to_h))
  end

  private

  def invoice_params
    params.permit(Invoice.attribute_names)
  end
end
