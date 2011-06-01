require 'spec_helper'

describe User do

  before(:each) do
    @user = Factory.create(:registered_user)
    @auth_cred = {
      "uid" => "9876543210",
      "credentials" => {"token" => "myfacebooktoken"},
      "user_info" => {"first_name" => "John", "last_name" => "Doe"}
    }
  end

  it { should validate_presence_of(:facebook_uid) }

  it { should validate_uniqueness_of(:facebook_uid) }

  it { should validate_presence_of(:profile_picture) }

  it { should validate_presence_of(:public_page_url) }

  it { should have_many(:friendships) }

  it { should have_many(:friends) }

  it { should have_many(:user_jobs) }

  it { should have_many(:photos) }

  it { should have_many(:votes) }

  it { should have_many(:photo_permissions) }

  it { should have_many(:friend_photos) }

  it "should have a full name" do
    @user.full_name.should == "#{@user.first_name} #{@user.last_name}"
  end

  it "should create a new account using facebook authentication info" do
    stub_facebook_profile
    expect {
      user = User.find_or_create_with_omniauth(@auth_cred)
    }.to change(User, :count).by(1)
  end

  it "should friend with others" do
    other = Factory.create(:user)
    expect {
      @user.friend(other)
    }.to change(Friendship, :count).by(2)
  end

  describe "friend?" do
    it "should respond true if user is friend with other" do
      other = Factory.create(:user)
      @user.friend(other)
      @user.friend?(other).should == true
    end

    it "should respond true if user is friend with other (using facebook_uid)" do
      other = Factory.create(:user)
      @user.friend(other)
      @user.friend?(other.facebook_uid).should == true
    end

    it "should respond false if user isn't friend with other" do
      other = Factory.create(:user)
      @user.friend?(other.facebook_uid).should == false
    end

    it "should respond false if is a new friend" do
      @user.friend?("9823113111100083").should == false
    end
  end

  it "should invite to friends to vote" do
    other = Factory.create(:user)
    @user.friend(other)
    invite = {:email => "user@facebook.com", :subject => "Vote My Three Best Photos!!",
      :message => "Hi #{other.first_name}: mythreebest.com/vote/#{@user.id}"}
    expect {
      @user.invite(other, invite)
    }.to change(Invite, :count).by(1)
  end

  it "should re-invite to friends to vote" do
     other = Factory.create(:user)
    @user.friend(other)
    invite = {:email => "user@facebook.com", :subject => "Vote My Three Best Photos!!",
      :message => "Hi #{other.first_name}: mythreebest.com/vote/#{@user.id}"}
    @user.invite(other, invite)
    expect {
      @user.invite(other, invite)
    }.to_not change(Invite, :count)
  end

  it "should invite to all friends with a facebook wall post" do
    expect {
      @user.invite_all
    }.to change(UserJob, :count).by(1)
  end

  it "should vote to a friend in an allowed photo" do
    other = Factory.create(:registered_user)
    photo = Factory.create(:photo, :user_id => other.id)
    PhotoPermission.create(:owner_id => other.id, :friend_id => @user.id, 
                           :photo_id => photo.id)
    @user.friend(other)
    expect {
      @user.vote([photo])
    }.to change(Vote, :count).by(1)
  end

  it "shouldn't vote to a friend in a disallowed photo" do
    other = Factory.create(:registered_user)
    photo = Factory.create(:photo, :user_id => other.id)

    @user.friend(other)
    expect {
      @user.vote([photo])
    }.not_to change(Vote, :count)
  end

  it "shouldn't vote to more than three photos of a friend" do
    other = Factory.create(:registered_user)
    @user.friend(other)
    photos = []
    (1..4).each do
      photo = Factory.create(:photo, :user_id => other.id)
      PhotoPermission.create(:owner_id => other.id, :friend_id => @user.id,
                             :photo_id => photo.id)
      photos << photo
    end

    expect {
      @user.vote(photos)
    }.to change(Vote, :count).by(3)
  end

  it "should respond if friend had voted to other" do
    other = Factory.create(:registered_user)
    @user.friend(other)
    photos = []
    (1..3).each do
      photo = Factory.create(:photo, :user_id => other.id)
      PhotoPermission.create(:owner_id => other.id, :friend_id => @user.id,
                             :photo_id => photo.id)
      photos << photo
    end
    @user.vote(photos)

    @user.voted?(other).should == true
  end

  it "should unvote a photo" do
    other = Factory.create(:registered_user)
    @user.friend(other)
    photo = Factory.create(:photo, :user_id => other.id)
    PhotoPermission.create(:owner_id => other.id, :friend_id => @user.id,
                           :photo_id => photo.id)
    @user.vote([photo])

    expect {
      @user.unvote(photo)
    }.to change(Vote, :count).by(-1)
  end

  it "should get voted photos for a specific friend" do
    other = Factory.create(:registered_user)
    @user.friend(other)
    photos = []
    (1..3).each do
      photo = Factory.create(:photo, :user_id => other.id)
      photos << photo
      PhotoPermission.create(:owner_id => other.id, :friend_id => @user.id,
                             :photo_id => photo.id)
    end
    @user.vote(photos)
    @user.votes_for(other).should == photos.map(&:votes).flatten
  end

  it "should get their voted photos" do
    other = Factory.create(:registered_user)
    @user.friend(other)
    photos = []
    (1..5).each do
      photo = Factory.create(:photo, :user_id => other.id)
      photos << photo
      PhotoPermission.create(:owner_id => other.id, :friend_id => @user.id,
                             :photo_id => photo.id)
    end
    @user.vote(photos)
    photos[0].update_attribute('total_votes', 10)
    photos[1].update_attribute('total_votes', 20)
    photos[2].update_attribute('total_votes', 5)
    other.voted_photos.should == [photos[1], photos[0], photos[2]]
  end

  it "should have registered_friends" do
    friend1 = Factory.create(:registered_user)
    friend2 = Factory.create(:user)
    friend3 = Factory.create(:registered_user)
    @user.friend(friend1)
    @user.friend(friend2)
    @user.friend(friend3)

    @user.registered_friends.should == [friend1, friend3]
  end

  it "should get only allowed photos and prioritized" do
    friend = Factory.create(:registered_user)
    @user.friend(friend)
    photo1 = Factory.create(:photo, :user_id => @user.id, :profile_picture => true)
    photo2 = Factory.create(:photo, :user_id => @user.id)
    photo3 = Factory.create(:photo, :user_id => @user.id)
    photo4 = Factory.create(:photo, :user_id => @user.id)
    PhotoPermission.create(:photo_id => photo1.id, :owner_id => @user.id, :friend_id => friend.id)
    PhotoPermission.create(:photo_id => photo3.id, :owner_id => @user.id, :friend_id => friend.id)
    PhotoPermission.create(:photo_id => photo4.id, :owner_id => @user.id, :friend_id => friend.id)
    PhotoTag.create(:photo_id => photo4.id, :user_id => friend.id)

    friend.photos_for_friend(@user).should == [photo1, photo4, photo3]
  end

  it "should get top photos" do
    photo = Factory.create(:photo, :user_id => @user.id)
    @user.top_photo_one_id = photo.id
    @user.save

    @user.top_photo_one.should == photo
  end

  it "should set top photos" do
    photo = Factory.create(:photo, :user_id => @user.id)
    @user.top_photo_one = photo
    @user.save

    @user.top_photo_one.should == photo
  end
end






# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  first_name         :string(255)
#  last_name          :string(255)
#  facebook_uid       :string(255)     not null
#  facebook_token     :string(255)
#  sign_in_count      :integer         default(0)
#  current_sign_in_at :datetime
#  last_sign_in_at    :datetime
#  current_sign_in_ip :string(255)
#  last_sign_in_ip    :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  profile_picture    :string(255)
#  top_photo_one_id   :integer
#  top_photo_two_id   :integer
#  top_photo_three_id :integer
#  public_page        :boolean         default(TRUE)
#  public_page_url    :string(255)
#  email              :string(255)
#

