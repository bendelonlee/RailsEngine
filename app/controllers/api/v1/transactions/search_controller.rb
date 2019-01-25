class Api::V1::Transactions::SearchController < ApplicationController
  def show
    attribute = (Transaction.attribute_names & params.keys).first
    render json: TransactionSerializer.new(Transaction.custom_where(attribute, params[attribute]).first)
  end
  def index
    attribute = (Transaction.attribute_names & params.keys).first
    render json: TransactionSerializer.new(Transaction.custom_where(attribute, params[attribute]))
  end
end
