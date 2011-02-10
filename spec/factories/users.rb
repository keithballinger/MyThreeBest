# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name  'Doe'
    facebook_uid '1234567890'
    facebook_token 'myverylargefacebooktoken'
  end
end
