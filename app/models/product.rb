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
  attr_accessible :description, :permalink, :title, :attachments_attributes, :images_attributes, :price_in_cents, :sample

  acts_as_commentable

  has_many :attachments, dependent: :destroy
  has_many :images, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :attachments, presence: { message: "Please upload an attachment"}
  validates :images, presence: { message: "Please upload an image" }
  validates :price_in_cents, presence: true, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ }, :numericality => {:greater_than => 0, :less_than => 1000000}

  accepts_nested_attributes_for :attachments
  accepts_nested_attributes_for :images

  before_create :generate_permalink, :convert_price_to_cents

  has_attached_file :sample,
                    path: 'sale/:permalink/download_attachment'

  # overriding to have :permalink in the routes instead of :id
  def to_param
    permalink
  end

  def generate_permalink
    self.permalink = clean_parameterized_title
    last_matching_links = Product.where("permalink SIMILAR TO ?","#{permalink}(-[0-9]+)?").order("LENGTH(permalink) ASC , permalink ASC").last
    if !last_matching_links.nil?
      num = last_matching_links.permalink.split('-').last.to_i + 1
      self.permalink = "#{permalink}-#{num}"
    elsif self.permalink == 'new'
      self.permalink = "new-1"
    end
  end

  private

  def clean_parameterized_title
    self.title.downcase.parameterize.gsub(/[^0-9A-Za-z-]/, '')
  end

  def convert_price_to_cents
    self.price_in_cents = price_in_cents.to_f * 100
  end
end
