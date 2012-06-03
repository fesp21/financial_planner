FactoryGirl.define do
  factory :user do
    name "Mr Fake"
    email "fake@example.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :category do
  	name "cats"
  	budget "150.00"
  end
end
