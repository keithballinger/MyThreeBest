require 'spec_helper'

describe User do

  before(:each) do
    @user = Factory.create(:user)
  end

  it { should validate_presence_of(:facebook_uid) }

  it { should validate_uniqueness_of(:facebook_uid) }

  it { should validate_presence_of(:facebook_token) }

end
