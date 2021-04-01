FactoryGirl.define do
  factory :user do
    name 'emma'
    email 'emma@example.com'
    password '123456'
    password_confirmation '123456'
  end

  factory :confirmed_user, parent: :user do
    after(:create, &:confirm!)
  end
end
