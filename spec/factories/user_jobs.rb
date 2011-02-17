# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_job do
      job_id "MyString"
      user_id 1
      type "MyString"
    end
end