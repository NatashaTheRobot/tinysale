class CommentsController < ApplicationController
  respond_to :json, only: [:create]

  def create
    @new_comment = Comment.build_from( params, user_id )
    if !@new_comment.spam? and @new_comment.save!
      cookies[:reviewer] = @new_comment.lead.token unless user_id.present?
      #@comment_output = { title: @new_comment.title,
      #                    avatar: view_context.author_image(@new_comment),
      #                    author_name: view_context.author_name(@new_comment),
      #                    rating: @new_comment.rating,
      #                    body: @new_comment.body,
      #                    date: @new_comment.created_at.strftime("%b %d, %Y")}
      if params[:partial]
        render :partial => "comment" , locals: { comment: @new_comment }
      else
        respond_with @comment_output, location: @new_comment, status: :ok
      end
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