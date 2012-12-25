# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment do
    access_token ENV['STRIPE_SECRET']
    publishable_key ENV['STRIPE_PUBLISHABLE']
    user
  end
end
