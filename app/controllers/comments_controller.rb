class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    comment = params[:comment]
    type = comment[:c_type]
    commentable = type.constantize.find(comment[:c_id])
    new_comment = Comment.build_from(commentable, current_user.id, comment[:body])
    new_comment.title = comment[:title]
    new_comment.save unless new_comment.spam?
    redirect_to commentable
  end
end
