class EmailsController < ApplicationController
  include Sendgrid

  def create
    email = params[:email]
    if email =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      Sendgrid.add_to_launch_list(email)
      head :no_content
    else
      head :unprocessable_entity
    end
  end

end
