class Transaction < ActiveRecord::Base
  belongs_to :product
  attr_accessible :email, :product

  after_save :send_product_emails

  def send_product_emails
    ProductMailer.product_purchase_email(self).deliver
    ProductMailer.product_sold_email(self).deliver
  end

end
