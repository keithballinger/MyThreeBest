class Vote < ActiveRecord::Base

  # - Associations
  belongs_to :photo
  belongs_to :voter, :class_name => "User"

  # - Validations
  validates_uniqueness_of :voter_id, :scope => :photo_id

  # - Callbacks
  after_create :update_photo_votes
  after_destroy :update_photo_votes

  def update_photo_votes
    photo = self.photo
    photo.update_attribute(:total_votes, photo.votes.count)
    perform_top_calculation
  end

  private

  def perform_top_calculation
    job_id = TopCalculation.create(:user_id => self.photo.user.id)
    Rails.logger.info "[Queued Job with id #{job_id}]"
  end

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

