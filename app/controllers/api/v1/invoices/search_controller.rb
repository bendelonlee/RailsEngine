class Api::V1::Invoices::SearchController < ApplicationController
  def show
    attribute = (Invoice.attribute_names & params.keys).first
    render json: InvoiceSerializer.new(Invoice.custom_where(attribute, params[attribute]).first)
  end
  def index
    attribute = (Invoice.attribute_names & params.keys).first
    render json: InvoiceSerializer.new(Invoice.custom_where(attribute, params[attribute]))
  end
end
