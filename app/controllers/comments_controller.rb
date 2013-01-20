class CommentsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json, only: [:create]

  def create
    comment = params[:comment]
    type = comment[:commentable_type]
    commentable = type.constantize.find(comment[:commentable_id].to_i)
    @new_comment = Comment.build_from(commentable, current_user.id, comment[:body])
    @new_comment.title = comment[:title]
    score = params[:score]
    @new_comment.rating = score.present? ? score : 0
    if !@new_comment.spam? and @new_comment.save
      @comment_output = { title: @new_comment.title,
                          avatar: view_context.image_for(@new_comment.user, '25x25'),
                          rating: @new_comment.rating,
                          body: @new_comment.body }
      respond_with @comment_output, location: @new_comment, status: :ok
    else
      # include what do when comment is spam first
      respond_with @new_comment.errors, location: @new_comment, status: :unprocessable_entity
    end
  end
end
