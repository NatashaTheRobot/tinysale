module ProductsHelper
  def file_type(product)
    content_type = product.attachments.first.item_content_type
    content_type.split('/').last.upcase
  end

  def file_size(product)
    size = product.attachments.first.item_file_size / 1000.00
    size.round
  end

  def price_in_dollars(product)
    price = product.attachments.first.price_in_cents/100.00
    number_to_currency(price)
  end
end
