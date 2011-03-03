class PhotoPermission < ActiveRecord::Base

  # - Validations
  validates_presence_of :owner_id
  validates_presence_of :friend_id
  validates_presence_of :photo_id
  validates_uniqueness_of :photo_id, :scope => [:friend_id, :owner_id]

  # - Associations
  belongs_to :friend, :class_name => 'User', :foreign_key => 'friend_id'
  belongs_to :owner, :class_name => 'User', :foreign_key => 'owner_id'
  belongs_to :photo, :class_name => 'Photo', :foreign_key => 'photo_id'
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

