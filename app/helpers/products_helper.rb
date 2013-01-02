module ProductsHelper
  def file_type(product)
    content_type = product.attachments.first.item_content_type
    content_type.split('/').last.upcase
  end

  def file_size(product)
    product.attachments.first.item_file_size / 1000
  end

  def price_in_dollars(product)
    price = product.attachments.first.price_in_cents/100
    number_to_currency(price)
  end
end
