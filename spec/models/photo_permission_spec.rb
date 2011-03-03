require 'spec_helper'

describe PhotoPermission do
  before(:all) do
    user = Factory(:registered_user)
    photo = Factory(:photo, :user_id => user.id)
    friend = Factory(:registered_user)
    @photo_permission = PhotoPermission.create(:owner_id => user.id, :photo_id => photo.id, 
                                            :friend_id => friend.id)
  end
  it { should validate_presence_of(:photo_id) }
  it { should validate_presence_of(:friend_id) }
  it { should validate_presence_of(:owner_id) }
  it { should belong_to(:owner) }
  it { should belong_to(:friend) }
  it { should belong_to(:photo) }
  it { should validate_uniqueness_of(:photo_id).scoped_to([:friend_id, :owner_id]) }
end

# == Schema Information
#
# Table name: photo_permissions
#
#  id         :integer         not null, primary key
#  photo_id   :integer         not null
#  owner_id   :integer         not null
#  friend_id  :integer         not null
#  created_at :datetime
#  updated_at :datetime
#

