# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    user nil
    title "My Book"
    description "This is the best book you'll ever read"
  end
end
