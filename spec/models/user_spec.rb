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

  it { should have_many(:friendships) }

  it { should have_many(:friends) }

  it "should create a new account using facebook authentication info" do
    expect {
      user = User.create_with_omniauth(@auth_cred)
    }.to change(User, :count).by(1)
  end

  it "should friend with others" do
    other = Factory.create(:user)
    expect {
      @user.friend(other)
    }.to change(Friendship, :count).by(2)
  end

  it "should respond true if is friend with other" do
    other = Factory.create(:user)
    @user.friend(other)
    @user.friend?(other).should == true
  end

  it "should respond false if isn't friend with other" do
    other = Factory.create(:user)
    @user.friend?(other).should == false
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
#  facebook_token     :string(255)     not null
#  sign_in_count      :integer         default(0)
#  current_sign_in_at :datetime
#  last_sign_in_at    :datetime
#  current_sign_in_ip :string(255)
#  last_sign_in_ip    :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

