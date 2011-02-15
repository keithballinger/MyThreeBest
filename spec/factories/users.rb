# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :facebook_uid do |n|
    (rand(100000) + 10000000 + n).to_s
  end

  factory :user do
    first_name Faker::Name.first_name
    last_name  Faker::Name.last_name
    facebook_uid
  end

  factory :registered_user, :parent => :user do
    facebook_token 'myverylargefacebooktoken'
  end

end
