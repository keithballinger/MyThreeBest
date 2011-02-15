require 'spec_helper'

describe Friendship do

  before(:each) do
    user1 = Factory(:registered_user)
    user2 = Factory(:user)
    user1.friend(user2)
  end

  it { should belong_to(:user) }
  it { should belong_to(:friend) }
  it { should validate_uniqueness_of(:friend_id).scoped_to(:user_id) }
end
