# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email 'user@test.com'
    password 'thisismypassword1'
    password_confirmation 'thisismypassword1'
    remember_me true
    bio "i'm the best seller you'll ever meet"

    factory :another_user do
      email 'another_user@test.com'
    end
  end
end
