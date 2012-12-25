class PaymentsController < ApplicationController
  before_filter :authenticate_user!

  def new
    Payment.create_from_tokens(current_user, params[:code])
  end

  def index

  end

end
