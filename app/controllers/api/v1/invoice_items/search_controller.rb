class Api::V1::InvoiceItems::SearchController < ApplicationController
  def show
    attribute = (InvoiceItem.attribute_names & params.keys).first
    render json: InvoiceItemSerializer.new(InvoiceItem.custom_where(attribute, params[attribute]).first)
  end
  def index
    attribute = (InvoiceItem.attribute_names & params.keys).first
    render json: InvoiceItemSerializer.new(InvoiceItem.custom_where(attribute, params[attribute]))
  end
end
