require 'spec_helper'

describe Invite do
  before(:each) do
   user1 = Factory.create(:registered_user)
   user2 = Factory.create(:user)
   @invite = Invite.create(:inviter_id => user1.id, :invited_id => user2.id, :status => "pending")
  end

  it { should validate_presence_of(:inviter_id) }
  it { should validate_presence_of(:invited_id) }
  it { should validate_presence_of(:status) }

  it { should validate_uniqueness_of(:invited_id).scoped_to(:inviter_id) }
end

# == Schema Information
#
# Table name: invites
#
#  id         :integer         not null, primary key
#  inviter_id :integer
#  invited_id :integer
#  status     :string(255)
#  created_at :datetime
#  updated_at :datetime
#
