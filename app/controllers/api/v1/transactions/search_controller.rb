class Api::V1::Transactions::SearchController < ApplicationController
  def show
    render json: TransactionSerializer.new(Transaction.custom_where(transaction_params.to_h).first)
  end
  def index
    render json: TransactionSerializer.new(Transaction.custom_where(transaction_params.to_h))
  end

  private

  def transaction_params
    params.permit(Transaction.attribute_names)
  end
end
