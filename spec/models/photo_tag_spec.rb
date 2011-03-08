require 'spec_helper'

describe PhotoTag do
  it { should validate_presence_of(:photo_id) }
  it { should validate_presence_of(:user_id) }
  it { should belong_to(:photo) }
  it { should belong_to(:user) }
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

