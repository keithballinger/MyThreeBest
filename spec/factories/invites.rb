# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invite do
      inviter_id 1
      invited_id 1
      status "MyString"
    end
end