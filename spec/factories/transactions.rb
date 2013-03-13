# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    email "natasha@natashatherobot.com"
    product FactoryGirl.create(:product)
  end
end
