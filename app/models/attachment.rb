# == Schema Information
#
# Table name: attachments
#
#  id                :integer          not null, primary key
#  status            :string(255)
#  price_in_cents    :integer
#  product_id        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  item_file_name    :string(255)
#  item_content_type :string(255)
#  item_file_size    :integer
#  item_updated_at   :datetime
#

class Attachment < ActiveRecord::Base
  attr_accessible :price_in_cents, :status, :item

  belongs_to :product

  has_attached_file :item

  validates_attachment_presence :item
  validates_attachment_size :item, less_than: 10.megabytes
end
