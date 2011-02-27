class Vote < ActiveRecord::Base

  # - Associations
  belongs_to :photo
  belongs_to :voter, :class_name => "User"

  # - Validations
  validates_uniqueness_of :voter_id, :scope => :photo_id

end



# == Schema Information
#
# Table name: votes
#
#  id         :integer         not null, primary key
#  voter_id   :integer         not null
#  photo_id   :integer         not null
#  created_at :datetime
#  updated_at :datetime
#

