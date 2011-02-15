# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name  'Doe'
    facebook_uid (rand(100000) + 10000000).to_s
    facebook_token 'myverylargefacebooktoken'
  end

end
