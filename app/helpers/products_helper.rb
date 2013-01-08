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
    ratings = @comments.collect { |comment| comment.rating }
    (ratings.reduce(:+).to_f / ratings.size).round
  end
end
