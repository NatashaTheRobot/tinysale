class PaymentsController < ApplicationController
  before_filter :authenticate_user!

  def new
    payment = Payment.create_from_tokens(current_user, params[:code])
    redirect_to payments_path if payment == :error #add error message
  end

  def index

  end

end
