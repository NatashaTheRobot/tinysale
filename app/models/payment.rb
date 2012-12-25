class Payment < ActiveRecord::Base
  belongs_to :user
  attr_accessible :access_token, :publishable_key

  def self.create_from_tokens(user, auth_code)
    tokens = self.add_tokens(auth_code)
    if tokens.has_key?(:access_token)
      payment = self.new( access_token: tokens['access_token'],
                          publishable_key: tokens['stripe_publishable_key'])
      payment.user = user
      payment.save!
    else
      return :error
    end
  end

  private

  def self.add_tokens(auth_code)
    request = Typhoeus::Request.post("https://connect.stripe.com/oauth/token",
                                     headers: { Authorization: "Bearer #{ENV['STRIPE_SECRET']}" },
                                     params: {:code => auth_code , :grant_type => "authorization_code" }
    )
    JSON.parse(request.body)
  end
end

#stripe connect response
#{"access_token"=>"sk_test_PgQdLXYq138CFKzcotHiBQb6",
#"refresh_token"=>"rt_0yjiQyzuHLzBPFmzbfDm06GkL90pcOOknVjqrEGO6TE4rJUQ",
#"token_type"=>"bearer", "scope"=>"read_only",
#"stripe_user_id"=>"acct_0quRJAW5yVxOwiv4TuzG",
#"livemode"=>false,
#"stripe_publishable_key"=>"pk_test_2wSgxfxY09f7MUltpUUhZ9YT"}

