# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_job do
    job_id "123456789"
    association :user, :factory => :registered_user
  end

  factory :friends_list_job, :parent => :user_job do
    job_type "friends_list"
  end
end
