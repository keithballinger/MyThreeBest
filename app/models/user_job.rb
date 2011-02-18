class UserJob < ActiveRecord::Base
  # - Associations
  belongs_to :user

  # - Validations
  validates_uniqueness_of :job_id
  validates_presence_of :job_id
  validates_presence_of :user_id
  validates_presence_of :job_type

  def status
    Resque::Status.get(self.job_id).status
  end

end


# == Schema Information
#
# Table name: user_jobs
#
#  id         :integer         not null, primary key
#  job_id     :string(255)     not null
#  user_id    :integer         not null
#  job_type   :string(255)     not null
#  created_at :datetime
#  updated_at :datetime
#

