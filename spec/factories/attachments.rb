# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attachment do
    status "MyString"
    price_in_cents 1
    references ""
  end
end
