class PaymentsController < ApplicationController
  before_filter :authenticate_user!

  def new
    payment = Payment.create_from_tokens(current_user, params[:code])
    redirect_to payments_path if payment == :error #add error message
  end

  def index

  end

  #def create
  #  amount =
  #  Stripe::Charge.create(
  #      :amount      => @amount,
  #      :card        => params[:stripeToken],
  #      :description => 'Sinatra Charge',
  #      :currency    => 'usd'
  #  )
  #end

end
