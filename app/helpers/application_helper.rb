module ApplicationHelper
  def title(product)
    product.present? ? product.title : 'tinysale'
  end

  def image_for(user, size = nil)
    image_tag(image_url(user), alt: user.username, class: "avatar", size: size)
  end

  def star_button(rateable, button_num, rating, split = 1, disabled = true)
    radio_button_tag( star_name(split, rateable) ,
                      nil ,
                      star_checked?(button_num, rating, split) ,
                      star_options(split, disabled) )
  end

  def star_button_rate(rateable, value, checked)
    radio_button_tag("rating[#{rateable.id}]", value, checked, :class => 'star')
  end

  def star_split(rating)
    if rating % 1 != 0
      remainder = rating - rating.round
      return (1/remainder).round.abs
    end
    return 1
  end

  private

  # user image helpers
  def image_url(user)
    user.avatar? ? user.avatar : gravatar_url(user.email.downcase)
  end

  def gravatar_url(email)
    gravatar_id = Digest::MD5::hexdigest(email)
    "https://secure.gravatar.com/avatar/#{gravatar_id}"
  end

  # star helper methods
  def star_name(split, rateable)
    funword = rateable.class == Comment ? 'trek' : 'bright'
    split == 1 ? "star3[#{funword}#{rateable.id}]" : "adv1[#{rateable.id}]"
  end

  def star_checked?(button_num, rating, split)
    button_num == (rating * split.to_f).round
  end

  def star_options(split, disabled)
    options = { :class => "star {split:#{split}}" }
    options[:disabled] = 'disabled' if disabled
    return options
  end

end
