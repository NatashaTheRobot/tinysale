# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  title       :string(255)
#  description :text
#  permalink   :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :permalink, :title, :attachments_attributes, :images_attributes

  has_many :attachments, dependent: :destroy
  has_many :images, dependent: :destroy

  validates :permalink, uniqueness: true, presence: true, exclusion: {in: %w[signup login home about]}
  validates :title, uniqueness: true, presence: true
  validates :description, presence: true

  accepts_nested_attributes_for :attachments
  accepts_nested_attributes_for :images

  validates_presence_of :attachments, :images

  before_validation :generate_permalink

  # overriding to have :permalink in the routes instead of :id
  def to_param
    permalink
  end

  def generate_permalink
    self.permalink ||= title.parameterize
  end
end
