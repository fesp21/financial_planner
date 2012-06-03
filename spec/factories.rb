FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Mr Fake #{n}" }
    sequence(:email) { |n| "fake#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"
  end

  factory :category do
  	name "cats"
  	budget "150.00"
  end

  factory :debit do
    cost "100.00"
    description "pizza on a bagel"
    user
  end
end
