class EmailsController < ApplicationController
  include Sendgrid

  def create
    email = params[:email]
    if email =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      response = Sendgrid.add_to_launch_list(email)
      response.has_key?("inserted") ? (head :no_content) : (head :unprocessable_entity)
    else
      head :unprocessable_entity
    end
  end

end
