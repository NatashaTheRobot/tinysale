class CommentsController < ApplicationController
  respond_to :json, only: [:create]

  def create
    @new_comment = Comment.build_from( params, user_id )
    if !@new_comment.spam? and @new_comment.save!
      @comment_output = { title: @new_comment.title,
                          avatar: avatar(@new_comment, '25x25'),
                          rating: @new_comment.rating,
                          body: @new_comment.body }
      respond_with @comment_output, location: @new_comment, status: :ok
    else
      # include what do when comment is spam first
      respond_with @new_comment.errors, location: @new_comment, status: :unprocessable_entity
    end
  end

  private

  def user_id
    current_user.present? ? current_user.id : nil
  end

  def avatar(comment, size)
    if comment.user.present?
      view_context.image_for(comment.user, size)
    else
      view_context.gravatar_for(comment.lead.email, size)
    end
  end
end