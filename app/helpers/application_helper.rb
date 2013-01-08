module ApplicationHelper
  def title(product)
    product.present? ? product.title : 'tinysale'
  end

  def image_for(user, size = nil)
    image_tag(image_url(user), alt: user.username, class: "gravatar", size: size)
  end

  def star_button(rateable, button_num, rating = nil, split = 1, disabled = true)
    rating = rating ? rating : 0
    checked = ( button_num == star_rating_from_rating( rating, split ) * split )
    options = { :class => "star {split:#{split}}" }
    options[:disabled] = 'disabled' if disabled
    name = split == 1 ? "star3[#{rateable.id}]" : "adv1[#{rateable.id}]"
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
