ActionMailer::Base.smtp_settings = {
    :address => "smtp.sendgrid.net",
    :port => 25,
    :domain => "tinysale.co",
    :authentication => :plain,
    :user_name => ENV['SENDGRID_USER'],
    :password => ENV['SENDGRID_PASS']
}

ActionMailer::Base.delivery_method = :smtp