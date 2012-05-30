FactoryGirl.define do
  factory :user do
    name     "Mr Fake"
    email    "fake@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
