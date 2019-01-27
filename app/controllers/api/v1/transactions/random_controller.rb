class Api::V1::Transactions::RandomController < ApplicationController
  def show
    render json: TransactionSerializer.new(Transaction.custom_sample)
  end
end
