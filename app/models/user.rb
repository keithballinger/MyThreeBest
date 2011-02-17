class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :facebook_uid, :facebook_token, :first_name, :last_name

  # - Validations
  validates_presence_of :facebook_uid
  validates_uniqueness_of :facebook_uid

  # - Associations
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :user_jobs

  # - Callbacks
  after_create :load_friends_list, :if => :facebook_token?


  def profile_picture(token = nil)
    if token
      graph = Koala::Facebook::GraphAPI.new(token)
    else
      graph = Koala::Facebook::GraphAPI.new(self.facebook_token)
    end
    return graph.get_picture(self.facebook_uid)
  end

  def friend(other)
    Friendship.create(:user_id => self.id, :friend_id => other.id)
    Friendship.create(:user_id => other.id, :friend_id => self.id)
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
    end
  end

  def load_friends_list
    job_id = FriendsList.create(:user_id => self.id)
    UserJob.create(:job_id => job_id, :user_id => self.id, :job_type => "friends_list")
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

