# == Schema Information
#
# Table name: images
#
#  id                 :integer          not null, primary key
#  product_id         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  cover_file_name    :string(255)
#  cover_content_type :string(255)
#  cover_file_size    :integer
#  cover_updated_at   :datetime
#

class Image < ActiveRecord::Base
  belongs_to :product

  attr_accessible :cover

  has_attached_file :cover, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  validates_attachment_presence :cover
  validates_attachment_size :cover, less_than: 10.megabytes
  validates_attachment_content_type :cover, content_type: ['image/jpeg', 'image/png']
end
