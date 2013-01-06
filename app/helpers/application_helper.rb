module ApplicationHelper
  def title(product)
    product.present? ? product.title : 'tinysale'
  end

  def image_for(user, size = nil)
    image_tag(image_url(user), alt: user.username, class: "gravatar", size: size)
  end

  #star button functions
  #rateable_id: comment.commentable_id,
  #    id: comment.id,
  #    rating: comment.rating,
  #    button_num: num,
  #    split: 1,
  #    disabled: true
  def star_button(comment, button_num, split = 1, disabled = true)
    rating = comment.rating ? comment.rating : 0
    checked = ( button_num == star_rating_from_rating( rating, split ) * split )
    options = { :class => "star {split:#{split}}" }
    options[:disabled] = 'disabled' if disabled
    name = ( split == 1  ) ? "star3[#{comment.id}]" : "adv1[#{comment.id}]"
    radio_button_tag( name , nil , checked , options )
  end

  def star_button_rate(rateable, value, checked)
    radio_button_tag("rating[#{rateable.id}]", value, checked, :class => 'star')
  end

  private

  def image_url(user)
    user.avatar? ? user.avatar : gravatar_url(user.email.downcase)
  end

  def gravatar_url(email)
    gravatar_id = Digest::MD5::hexdigest(email)
    "https://secure.gravatar.com/avatar/#{gravatar_id}"
  end

  def star_rating_from_rating( rating , split )
    (rating * split.to_f).round / split.to_f
  end
end
