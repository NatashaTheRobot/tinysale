class CommentsController < ApplicationController
  respond_to :json, only: [:create]

  def create
    comment = params[:comment]
    @new_comment = Comment.build_from( commentable_id: comment[:commentable_id],
                                       commentable_type: comment[:commentable_type],
                                       body: comment[:body],
                                       title: comment[:title],
                                       user_id: user_id,
                                       email: comment[:email],
                                       subtype: comment[:subtype],
                                       rating: rating(params[:score].to_i)
                                     )
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

  def rating(score)
    score.present? ? score : nil
  end

  def avatar(comment, size)
    unless comment.user_id.zero?
      view_context.image_for(comment.user, size)
    else
      view_context.gravatar_for(comment.email, size)
    end
  end
end