class Photo < ActiveRecord::Base

  # - Validations
  validates_presence_of :url
  validates_presence_of :total_votes
  validates_presence_of :facebook_id

  # - Associations
  belongs_to :user
  has_many :votes
  has_many :photo_tags
  has_many :tagged_users, :through => :photo_tags, :source => :user

  def priority(friend = nil)
    return 1 if self.profile_picture
    return 2 if friend && self.photo_tags.where(:user_id => friend.id).exists?
    return 3
  end
end



# == Schema Information
#
# Table name: photos
#
#  id              :integer         not null, primary key
#  title           :text
#  url             :string(255)     not null
#  preview_url     :string(255)
#  user_id         :integer         not null
#  total_votes     :integer         default(0)
#  created_at      :datetime
#  updated_at      :datetime
#  facebook_id     :string(255)
#  profile_picture :boolean         default(FALSE), not null
#

