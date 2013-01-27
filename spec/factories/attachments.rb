# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attachment do
    status "active"
    item File.new(Rails.root + 'spec/factories/images/rails.png')
  end
end
