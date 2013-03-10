class Transaction < ActiveRecord::Base
  belongs_to :product
  attr_accessible :email, :product
end
