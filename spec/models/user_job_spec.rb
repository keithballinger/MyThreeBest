require 'spec_helper'

describe UserJob do
  before(:each) do
    @user = Factory.create(:registered_user)
    @user_job = @user.user_jobs.where(:job_type => "friends_list").first
  end

  it { should belong_to(:user) }
  it { should validate_uniqueness_of(:job_id) }
  it { should validate_presence_of(:job_id) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:job_type) }

  it "should have a status" do
    @user_job.status.should == "queued"
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

