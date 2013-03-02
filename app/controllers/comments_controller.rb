class CommentsController < ApplicationController
  respond_to :json, only: [:create]

  def create
    @new_comment = Comment.build_from( params, user_id )
    if !@new_comment.spam? and @new_comment.save!
      cookies[:reviewer] = @new_comment.lead.token unless user_id.present?
      render :partial => "show" , locals: { comment: @new_comment }
    else
      # include what do when comment is spam first
      respond_with @new_comment.errors, location: @new_comment, status: :unprocessable_entity
    end
  end

  private

  def user_id
    current_user.present? ? current_user.id : nil
  end
end