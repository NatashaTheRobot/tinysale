module CommentsHelper
  def author_image(comment)
    comment.user.present? ? image_for(comment.user, "120x120") : gravatar_for(comment.lead.email, "120x120")
  end

  def author_name(comment)
    comment.user.present? ? comment.user.username : comment.lead.username
  end

end
