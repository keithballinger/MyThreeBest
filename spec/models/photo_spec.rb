require 'spec_helper'

describe Photo do
  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:total_votes) }
  it { should validate_presence_of(:facebook_id) }
  it { should belong_to(:user) }
  it { should have_many(:votes) }

  it "should return the highest priority if is a user profile picture"
  it "should return the second highest priority if the voter is tagged"
  it "should return the lowest priority if isn't a user profile picture and voter isn't tagged"
end


# == Schema Information
#
# Table name: photos
#
#  id          :integer         not null, primary key
#  title       :text
#  url         :string(255)     not null
#  preview_url :string(255)
#  user_id     :integer         not null
#  total_votes :integer         default(0)
#  created_at  :datetime
#  updated_at  :datetime
#  facebook_id :string(255)
#

