module Sendgrid
  class << self

    def add_to_launch_list(email)
      url = URI::encode("http://sendgrid.com/api/newsletter/lists/email/add.json?list=TinySale Launch&data={\"email\":\"#{email}\",\"name\":\"tinysale customer\"}&api_user=#{ENV['SENDGRID_USER']}&api_key=#{ENV['SENDGRID_PASS']}")
      response = Typhoeus::Request.get(url)
      JSON.parse(response.body)
    end

  end
end