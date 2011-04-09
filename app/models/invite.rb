class Invite < ActiveRecord::Base

  attr_accessor :invite
  # - Validations
  validates_presence_of :inviter_id
  validates_presence_of :invited_id
  validates_presence_of :status
  validates_uniqueness_of :invited_id, :scope => :inviter_id

  # - Associations
  belongs_to :inviter, :class_name => 'User', :foreign_key => 'inviter_id'
  belongs_to :invited, :class_name => 'User', :foreign_key => 'invited_id' 

  # - Callbacks
  after_create :send_friends_invite

  def send_friends_invite
    InviteMailer.invite_email(self.inviter, self.invited, self.invite).deliver
  end

end


# == Schema Information
#
# Table name: invites
#
#  id         :integer         not null, primary key
#  inviter_id :integer         not null
#  invited_id :integer         not null
#  status     :string(255)     not null
#  created_at :datetime
#  updated_at :datetime
#

