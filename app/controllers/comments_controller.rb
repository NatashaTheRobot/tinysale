class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    comment = params[:comment]
    rating = params[:rating]
    type = comment[:c_type]
    commentable = type.constantize.find(rating.keys.first.to_i)
    new_comment = Comment.build_from(commentable, current_user.id, comment[:body])
    new_comment.title = comment[:title]
    new_comment.rating = rating.values.first.to_i
    new_comment.save unless new_comment.spam?
    #commentable.rate_it(rating.values.first.to_i, current_user)
    redirect_to commentable
  end
end
