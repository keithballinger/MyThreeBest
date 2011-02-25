# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo do
    title { Faker::Lorem.words.join(" ") }
    url "http://facebook.com/random_photo.jpg"
    preview_url "http://facebook.com/random_photo_preview.jpg"
    user
    total_votes 0
  end
end
