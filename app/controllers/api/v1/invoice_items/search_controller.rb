class Api::V1::InvoiceItems::SearchController < ApplicationController
  def show
    iv_item = InvoiceItem.custom_where(invoice_item_params.to_h).limit(1).first
    render json: InvoiceItemSerializer.new(iv_item)
  end
  def index
    iv_item = InvoiceItem.custom_where(invoice_item_params.to_h)
    render json: InvoiceItemSerializer.new(iv_item)
  end

  private

  def invoice_item_params
    params.permit(InvoiceItem.attribute_names)
  end
end
