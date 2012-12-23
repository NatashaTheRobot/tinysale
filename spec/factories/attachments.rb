# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attachment do
    status "active"
    price_in_cents 100
    item File.new(Rails.root + 'spec/factories/images/rails.png')
  end
end
