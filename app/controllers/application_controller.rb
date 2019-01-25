class ApplicationController < ActionController::API
  helper_method :int_to_dollar_amount
  def int_to_dollar_amount(int)
    (int / 100.0).to_s
  end
end
