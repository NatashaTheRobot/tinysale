class Lead < ActiveRecord::Base
  attr_accessible :email, :token
  has_many :comments

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, presence: true

  #validates :token, uniqueness: true, presence: true

  before_create :generate_token

  def self.build_from(email)
    Lead.new(email: email)
  end

  private

  def generate_token
    begin
      token = SecureRandom.urlsafe_base64
    end while Lead.where(:token => token).exists?
    self.token = token
  end
end
