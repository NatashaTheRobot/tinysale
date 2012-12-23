# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :image do
    cover Image.new :photo => File.new(Rails.root + 'spec/fixtures/images/rails.png')
  end
end
