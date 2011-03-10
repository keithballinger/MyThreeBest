class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :facebook_uid, :facebook_token, :first_name, :last_name, :profile_picture,
                  :top_photo_one_id, :top_photo_two_id, :top_photo_three_id

  # - Validations
  validates_presence_of :facebook_uid
  validates_uniqueness_of :facebook_uid
  validates_presence_of :profile_picture

  # - Associations
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :user_jobs
  has_many :photos
  has_many :votes, :through => :photos
  has_many :photo_permissions, :foreign_key => 'friend_id'
  has_many :friend_photos, :through => :photo_permissions, :source => :photo


  # - Callbacks
  after_create :load_user_data, :if => :facebook_token?
  after_update :load_user_data, :if => lambda { |user| user.sign_in_count == 0 }


  # - Auth methods

  def self.find_or_create_with_omniauth(auth)
    user = self.find_by_facebook_uid(auth["uid"])
    if user
      user.update_attribute(:facebook_token, auth["credentials"]["token"])
    else
      user = self.create_with_omniauth(auth)
    end
    user
  end


  # - Friends methods

  def friend(other)
    Friendship.create!(:user_id => self.id, :friend_id => other.id)
    Friendship.create!(:user_id => other.id, :friend_id => self.id)
    true
  end

  def friend?(other)
    if other.instance_of?(User)
      user = other
    else
      user = User.find_by_facebook_uid(other)
    end
    if user
      Friendship.where(:user_id => self.id, :friend_id => user.id).exists?
    else
      false
    end
  end

  def registered_friends
    self.friends.where(User.arel_table[:facebook_token].not_eq(nil))
  end

  def photos_for_friend(friend)
    self.friend_photos.where(:user_id => friend.id).sort_by{|photo| photo.priority(self)}
    #sql_literal = Arel::SqlLiteral.new(PhotoPermission.select(:photo_id).where(:owner_id => friend.id, :friend_id => self.id).to_sql)
    #friend.photos.where(Photo.arel_table[:id].in(sql_literal))
  end


  # - Invite methods

  def invite_all
    job_id = PostInvite.create(:inviter_id => self.id)
    UserJob.create!(:job_id => job_id, :user_id => self.id, :job_type => "post_invite", :status => "queued")
  end

  def invite(user)
    invite = Invite.create!(:inviter_id => self.id, :invited_id => user.id, :status => "invited")
    invite.send_friends_invite
  end

  #def invited?(user)
    #invite = Invite.where(:inviter_id => self.id, :invited_id => user.id, :status => "invited").first
  #end


  # - Vote methods

  def vote(photo)
    return unless PhotoPermission.where(:photo_id => photo.id, :friend_id => self.id, :owner_id => photo.user.id).exists?
    return if voted?(photo.user)
    Vote.create(:photo_id => photo.id, :voter_id => self.id)
  end

  def voted?(user)
    vote_count = user.votes.where(:voter_id => self.id).count
    vote_count == 3
  end

  def unvote(photo)
    return unless PhotoPermission.where(:photo_id => photo.id, :friend_id => self.id, :owner_id => photo.user.id).first
    vote = Vote.where(:photo_id => photo.id, :voter_id => self.id).first
    vote.destroy
  end

  def votes_for(friend)
    friend.votes.where(:voter_id => self.id).includes(:photo).map(&:photo)
  end

  def voted_photos
    self.photos.where('total_votes > 0').order('total_votes DESC').includes(:votes)
  end


  # Top Photo methods

  ['one', 'two', 'three'].each do |number|
    define_method "top_photo_#{number}" do
      Photo.find(self.instance_eval("top_photo_#{number}_id")) rescue nil
    end
    define_method "top_photo_#{number}=" do |photo|
      instance_eval("self.top_photo_#{number}_id = photo.id")
    end
  end


  # Job methods

  def friends_list_job
    self.user_jobs.where(:job_type => "friends_list").first
  end

  def user_photos_job
    self.user_jobs.where(:job_type => "user_photos").first
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
#  profile_picture    :string(255)
#  top_photo_one_id   :integer
#  top_photo_two_id   :integer
#  top_photo_three_id :integer
#

