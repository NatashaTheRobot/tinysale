module ApplicationHelper
  def title(product)
    product.present? ? product.title : 'tinysale'
  end
end
