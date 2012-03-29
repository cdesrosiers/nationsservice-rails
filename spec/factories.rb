FactoryGirl.define do
  factory :user do
    name      "Corey Desrosiers"
    email     "cmdesrosiers@hello.com"
    password  "foobar"
    password_confirmation "foobar"
  end
end
