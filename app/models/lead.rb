class Lead < ActiveRecord::Base
  attr_accessible :email, :token, :username

  has_many :comments

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, presence: true, uniqueness: true

  before_create :generate_token, :get_username

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

  def gravatar_id
    Digest::MD5::hexdigest(self.email)
  end

  def get_username
    response = Typhoeus.get("https://secure.gravatar.com/#{gravatar_id}.json")
    return nil if response.body =~ /User not found/
    user_info = JSON.parse(response.body)
    self.username = user_info["entry"].first["preferredUsername"]
  end
end
