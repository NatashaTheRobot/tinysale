Tinysale::Application.config.rakismet.key = ENV['AKISMET_API']
if Rails.env.production?
  Tinysale::Application.config.rakismet.url = 'http://tinysale.co'
  Tinysale::Application.config.rakismet.test = false
else
  Tinysale::Application.config.rakismet.url = 'http://localhost:3000'
  Tinysale::Application.config.rakismet.test = true
end