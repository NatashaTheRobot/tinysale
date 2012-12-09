#ActionMailer::Base.smtp_settings = {
#    :address => "smtp.sendgrid.net",
#    :port => 25,
#    :domain => "mysite.com",
#    :authentication => :plain,
#    :user_name => ENV['SENDGRID_USER'],
#    :password => ENV['SENDGRID_PASS']
#}

# http://sendgrid.com/api/newsletter/lists/email/add.json?list=TinySale%20Launch&data={%22email%22:%22joe@test.com%22,%22name%22:%22example%22}&api_user=#{ENV['SENDGRID_USER']}&api_key=#{ENV['SENDGRID_PASS']}