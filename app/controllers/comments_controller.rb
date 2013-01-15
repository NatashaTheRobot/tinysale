class CommentsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json, only: [:create]

  def create
    comment = params[:comment]
    rating = params[:rating]
    type = comment[:c_type]
    commentable = type.constantize.find(rating.keys.first.to_i)
    @new_comment = Comment.build_from(commentable, current_user.id, comment[:body])
    @new_comment.title = comment[:title]
    @new_comment.rating = rating.values.first.to_i
    if !@new_comment.spam? and @new_comment.save
      @comment_output = { title: @new_comment.title,
                         avatar: view_context.image_for(@new_comment.user, '25x25'),
                         rating: @new_comment.rating,
                         body: @new_comment.body }
      respond_with @comment_output, location: @new_comment, status: :ok
    else
      respond_with @new_comment.errors, status: :unprocessable_entity
    end
  end
end
