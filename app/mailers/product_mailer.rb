class ProductMailer < ActionMailer::Base
  default :from => 'natasha@tinysale.com'

  def product_purchase_email(transaction)
    @product = transaction.product
    mail to: transaction.email,
         subject: "You just bought #{@product.title}"
  end

  def product_sold_email(transaction)
    @transaction = transaction
    @product = transaction.product
    mail to: @product.user.email,
         subject: "Cha-Ching! You just sold #{@product.title}"
  end
end