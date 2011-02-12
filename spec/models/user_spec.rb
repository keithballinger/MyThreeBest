require 'spec_helper'

describe User do

  before(:each) do
    @user = Factory.create(:user)
    @auth_cred = {
      "uid" => "9876543210",
      "credentials" => {"token" => "myfacebooktoken"},
      "user_info" => {"first_name" => "John", "last_name" => "Doe"}
    }
  end

  it { should validate_presence_of(:facebook_uid) }

  it { should validate_uniqueness_of(:facebook_uid) }

  it { should validate_presence_of(:facebook_token) }

  it "should create a new account using facebook authentication info" do
    expect {
      user = User.create_with_omniauth(@auth_cred)
    }.to change(User, :count).by(1)
  end

  it "should have a friend list" do

    # stub external connection with Facebook
    graph = mock('GraphAPI')
    users = [{"name" => "John Doe", "id" => "1"}, {"name" => "Joe Dohn", "id" => "2"}]
    graph.stubs(:get_connections).returns(users)
    Koala::Facebook::GraphAPI.stubs(:new).returns(graph)


    @user.friends.size.should == 2

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

