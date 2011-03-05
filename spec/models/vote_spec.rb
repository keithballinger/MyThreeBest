require 'spec_helper'

describe Vote do

  before(:each) do
    @vote = Factory.create(:vote)
  end

  it { should belong_to(:voter) }
  it { should belong_to(:photo) }
  it { should validate_uniqueness_of(:voter_id).scoped_to(:photo_id) }

  it "should update photo total votes on create" do
    vote = Factory.build(:vote)
    expect {
      vote.save
    }.to change(vote.photo, :total_votes).by(1)
  end

  it "should update photo total votes on destroy" do
    vote = Factory.create(:vote)
    expect {
      vote.destroy
    }.to change(vote.photo, :total_votes).by(-1)
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

