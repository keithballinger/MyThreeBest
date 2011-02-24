class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :facebook_uid, :facebook_token, :first_name, :last_name, :profile_picture

  # - Validations
  validates_presence_of :facebook_uid
  validates_uniqueness_of :facebook_uid
  validates_presence_of :profile_picture

  # - Associations
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :user_jobs
  has_many :photos

  # - Callbacks
  after_create :load_user_data, :if => :facebook_token?

  def friend(other)
    Friendship.create!(:user_id => self.id, :friend_id => other.id)
    Friendship.create!(:user_id => other.id, :friend_id => self.id)
    true
  end

  def friend?(other)
    user = User.find_by_facebook_uid(other)
    if user
      return !Friendship.where(:user_id => self.id, :friend_id => user.id).blank?
    else
      return false
    end
  end

  def invite_all
    job_id = PostInvite.create(:inviter_id => self.id)
    UserJob.create(:job_id => job_id, :user_id => self.id, :job_type => "post_invite")
  end

  def invite(user)
    invite = Invite.create!(:inviter_id => self.id, :invited_id => user.id, :status => "invited")
    invite.send_friends_invite
  end

  def invited?(user)
    invite = Invite.where(:inviter_id => self.id, :invited_id => user.id, :status => "invited").first
    invite.send_friends_invite
  end

  def friends_list_job
    self.user_jobs.where(:job_type => "friends_list").first
  end

  def user_photos_job
    self.user_jobs.where(:job_type => "user_photos").first
  end

  def self.find_or_create_with_omniauth(auth)
    user = self.find_by_facebook_uid(auth["uid"])
    if user
      user.update_attribute(:facebook_token, auth["credentials"]["token"])
    else
      user = self.create_with_omniauth(auth)
    end
    return user
  end

  private

  def self.create_with_omniauth(auth)
    create! do |user|
      user.facebook_uid = auth["uid"]
      user.facebook_token = auth["credentials"]["token"]
      user.first_name = auth["user_info"]["first_name"]
      user.last_name = auth["user_info"]["last_name"]
      graph = Koala::Facebook::GraphAPI.new(auth["credentials"]["token"])
      user.profile_picture = graph.get_picture(auth["uid"])
    end
  end

  def load_user_data
    job_id = FriendsList.create(:user_id => self.id)
    Rails.logger.info "[Queued Job with id #{job_id}]"
    UserJob.create!(:job_id => job_id, :user_id => self.id, :job_type => "friends_list", :status => "queued")
    job_id = UserPhotos.create(:user_id => self.id)
    Rails.logger.info "[Queued Job with id #{job_id}]"
    UserJob.create!(:job_id => job_id, :user_id => self.id, :job_type => "user_photos", :status => "queued")
  end
end


# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  first_name         :string(255)
#  last_name          :string(255)
#  facebook_uid       :string(255)     not null
#  facebook_token     :string(255)
#  sign_in_count      :integer         default(0)
#  current_sign_in_at :datetime
#  last_sign_in_at    :datetime
#  current_sign_in_ip :string(255)
#  last_sign_in_ip    :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

