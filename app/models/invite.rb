class Invite < ActiveRecord::Base

  # - Validations
  validates_presence_of :inviter_id
  validates_presence_of :invited_id
  validates_presence_of :status
  validates_uniqueness_of :invited_id, :scope => :inviter_id

  # - Callbacks
  after_create :send_friends_invite

  def send_friends_invite
    job_id = FriendsInvite.create(:inviter_id => self.inviter_id, :invited_id => self.invited_id)
    UserJob.create(:job_id => job_id, :user_id => self.inviter_id, :job_type => "friends_invite")
  end
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

