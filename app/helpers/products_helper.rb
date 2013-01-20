module ProductsHelper
  def file_type
    content_type = @product.attachments.first.item_content_type
    content_type.split('/').last.upcase
  end

  def file_size
    size = @product.attachments.first.item_file_size / 1000.00
    size.round
  end

  def price_in_dollars
    price = @product.attachments.first.price_in_cents/100.00
    number_to_currency(price)
  end

  def average_rating
    return 0 if @comments.empty?
    ratings = @comments.collect { |comment| comment.rating }
    ratings.reject! { |r| r == 0 } # 0's don't count as ratings
    (ratings.reduce(:+).to_f / ratings.size)
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def user_data
    current_user ? 'y' : 'n'
  end
end
