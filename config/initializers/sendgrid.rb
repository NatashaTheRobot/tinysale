ActionMailer::Base.smtp_settings = {
    :address => "smtp.sendgrid.net",
    :port => 25,
    :domain => "tinysale.com",
    :authentication => :plain,
    :user_name => ENV['SENDGRID_USER'],
    :password => ENV['SENDGRID_PASS'],
    :port => 587,
    :enable_starttls_auto => true
}