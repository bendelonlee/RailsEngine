class Api::V1::InvoiceItems::SearchController < ApplicationController
  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.custom_where(invoice_item_params.to_h).limit(1).first)
  end
  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.custom_where(invoice_item_params.to_h))
  end

  private

  def invoice_item_params
    params.permit(InvoiceItem.attribute_names)
  end
end
