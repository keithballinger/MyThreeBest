# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo do
      title "MyText"
      url "MyString"
      preview_url "MyString"
      user_id 1
      total_votes 1
    end
end