# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attachment do
    status "active"
    price_in_cents 100
    item Image.new :photo => File.new(Rails.root + 'spec/fixtures/images/rails.png')
  end
end
