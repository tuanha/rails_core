FactoryGirl.define do
  factory :user do
    password = Faker::Internet.password(10, 20)
    email "test@example.com"
    password password
    password_confirmation password
    avatar Faker::Avatar.image
    role 'admin'
  end
end
