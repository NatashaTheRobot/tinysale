class Product < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :permalink, :title
end
