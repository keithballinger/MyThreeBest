# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vote do
      association :voter, :factory => :registered_user
      photo
    end
end
