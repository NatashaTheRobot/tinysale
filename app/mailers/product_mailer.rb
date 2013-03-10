class ProductMailer < ActionMailer::Base
  default :from => 'natasha@tinysale.com'

  def product_purchase_email(transaction)
    product = transaction.product
    mail to: transaction.email,
         subject: "You just bought #{product.title}",
         body: "Thank you for purchasing #{product.title} from #{product.user.username} for #{product.price_in_dollars}.\n
                You can <a href='#{product.attachments.first.item.expiring_url(60)}' target='_blank'> download your copy here.</a> (Keep in mind that this link expires 60 seconds after you open it) \n
                Enjoy!".html_safe
  end

  def product_sold_email(transaction)
    product = transaction.product
    mail to: product.user.email,
         subject: "Cha-Ching! You just sold #{product.title}",
         body: "Congratulations! You just sold #{product.title} to #{transaction.email}."
  end
end