FactoryGirl.define do
  factory :user do
    name 'emma'
    email 'emma@example.com'
    password '123456'
    password_confirmation '123456'
  end

  factory :user1 do
    name 'emmy'
    email 'emmy@example.com'
    password '123456'
    password_confirmation '123456'
  end

  factory parent: :user do
    after(:create)
  end
end
