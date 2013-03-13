FactoryGirl.define do
  factory :comment do
    title "My comment"
    body "This is a great product"
    subtype "comment"
  end

  factory :review do
    title "My review"
    body "This is a 5 star rock star"
    subtype "review"
    rating 5
  end
end