# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    user nil
    title "MyString"
    description "MyText"
    permalink "MyString"
  end
end
