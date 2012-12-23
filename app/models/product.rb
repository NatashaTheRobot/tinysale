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

  validates :permalink, exclusion: {in: %w[signup login home about]}
  validates :title, presence: true
  validates :description, presence: true
  validates :attachments, presence: { message: "Please upload an attachment"}
  validates :images, presence: { message: "Please upload an image" }

  accepts_nested_attributes_for :attachments
  accepts_nested_attributes_for :images

  before_create :generate_permalink

  # overriding to have :permalink in the routes instead of :id
  def to_param
    permalink
  end

  def generate_permalink
    self.permalink = title.downcase.parameterize
    last_matching_slug = Product.where("permalink SIMILAR TO ?","#{permalink}(-[0-9]+)?").order("permalink ASC").last
    if !similar_permalinks.empty?
      num = last_matching_slug.split('-').last.to_i + 1
      self.permalink = "#{permalink}-#{num}"
    end
  end
end
