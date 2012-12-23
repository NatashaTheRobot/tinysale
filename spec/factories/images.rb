# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :image do
    cover File.new(Rails.root + 'spec/factories/images/rails.png')
  end
end
