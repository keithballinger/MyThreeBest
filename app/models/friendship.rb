class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => 'User', :foreign_key => 'friend_id'
  validates_uniqueness_of :friend_id, :scope => :user_id
end

# == Schema Information
#
# Table name: friendships
#
#  id         :integer         not null, primary key
#  user_id    :integer         not null
#  friend_id  :integer         not null
#  created_at :datetime
#  updated_at :datetime
#

