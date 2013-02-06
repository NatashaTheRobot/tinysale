module ProductsHelper
  def product_url
    "#{root_url}sale/#{@product.permalink}"
  end

  def file_type
    content_type = @product.attachments.first.item_content_type
    content_type.split('/').last.upcase
  end

  def file_size
    size = @product.attachments.first.item_file_size / 1000.00
    size.round
  end

  def price_in_dollars
    price = @product.price_in_cents/100.00
    number_to_currency(price)
  end

  def average_rating
    return 0 if @comments.empty?
    return 0 if ratings.size == 0
    ratings.reduce(:+).to_f / ratings.size
  end

  def num_ratings
    return 0 if @comments.empty?
    ratings.size
  end

  def ratings
    ratings = @comments.collect { |comment| comment.rating }
    ratings.reject { |r| r.nil? }
  end
end
