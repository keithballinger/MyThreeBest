class Invite < ActiveRecord::Base
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

