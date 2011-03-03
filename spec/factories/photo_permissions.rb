# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo_permission do
      photo_id 1
      owner_id 1
      friend_id 1
    end
end