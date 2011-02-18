class Invite < ActiveRecord::Base

  # - Validations
  validates_presence_of :inviter_id
  validates_presence_of :invited_id
  validates_presence_of :status
  validates_uniqueness_of :invited_id, :scope => :inviter_id


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

