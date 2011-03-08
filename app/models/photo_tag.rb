class PhotoTag < ActiveRecord::Base

  # - Validations
  validates_presence_of :photo_id
  validates_presence_of :user_id

  # - Associations
  belongs_to :photo
  belongs_to :user
end

# == Schema Information
#
# Table name: photo_tags
#
#  id         :integer         not null, primary key
#  photo_id   :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

