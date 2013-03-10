class Transaction < ActiveRecord::Base
  belongs_to :product
  attr_accessible :email, :product

  after_save :send_product

  def send_product
    ProductMailer.product_email(self).deliver
  end

end
