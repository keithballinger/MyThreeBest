require 'spec_helper'

describe Photo do

  before(:each) do
    @user = Factory.create(:registered_user)
    @voter = Factory.create(:registered_user)
  end

  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:total_votes) }
  it { should validate_presence_of(:facebook_id) }
  it { should belong_to(:user) }
  it { should have_many(:votes) }
  it { should have_many(:photo_tags) }
  it { should have_many(:tagged_users) }

  it "should return the highest priority if is a user profile picture" do
    @photo = Factory.create(:photo, :user_id => @user.id, :profile_picture => true)

    @photo.priority.should == 1
  end

  it "should return the second highest priority if the voter is tagged" do
    @photo = Factory.create(:photo, :user_id => @user.id)
    PhotoTag.create(:user_id => @voter.id, :photo_id => @photo.id)

    @photo.priority(@voter).should == 2
  end
  it "should return the lowest priority if isn't a user profile picture and voter isn't tagged" do
    @photo = Factory.create(:photo, :user_id => @user.id)

    @photo.priority.should == 3
  end
end



# == Schema Information
#
# Table name: photos
#
#  id              :integer         not null, primary key
#  title           :text
#  url             :string(255)     not null
#  preview_url     :string(255)
#  user_id         :integer         not null
#  total_votes     :integer         default(0)
#  created_at      :datetime
#  updated_at      :datetime
#  facebook_id     :string(255)
#  profile_picture :boolean         default(FALSE), not null
#

