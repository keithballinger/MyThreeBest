class Vote < ActiveRecord::Base

  # - Associations
  belongs_to :photo
  belongs_to :voter, :class_name => "User"

  # - Validations
  validates_uniqueness_of :voter_id, :scope => :photo_id

end
