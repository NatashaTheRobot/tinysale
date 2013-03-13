# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    title "My Book"
    description "This is the best book you'll ever read"
    price_in_cents 100
    user { FactoryGirl.build :user }
    images [FactoryGirl.build(:image)]
    attachments [FactoryGirl.build(:attachment)]
  end
end
