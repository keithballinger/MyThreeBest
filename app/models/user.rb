class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :facebook_uid, :facebook_token, :first_name, :last_name, :profile_picture,
                  :top_photo_one_id, :top_photo_two_id, :top_photo_three_id, :public_page

  # - Validations
  validates_presence_of :facebook_uid
  validates_presence_of :profile_picture
  validates_presence_of :public_page_url
  validates_uniqueness_of :facebook_uid

  # - Associations
  has_many :friendships, :dependent => :destroy
  has_many :friends, :through => :friendships
  has_many :user_jobs, :dependent => :destroy
  has_many :photos, :dependent => :destroy
  has_many :votes, :through => :photos
  has_many :voters, :through => :votes, :uniq => true
  has_many :photo_permissions, :foreign_key => 'friend_id', :dependent => :destroy
  has_many :friend_photos, :through => :photo_permissions, :source => :photo


  # - Callbacks
  before_validation :generate_public_page_url, :on => :create
  after_create :load_user_data, :if => :facebook_token?
  before_create :generate_token


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

  def self.create_with_omniauth(auth)
    create! do |user|
      user.facebook_uid = auth["uid"]
      user.facebook_token = auth["credentials"]["token"]
      user.first_name = auth["user_info"]["first_name"]
      user.last_name = auth["user_info"]["last_name"]
      user.email = auth["user_info"]["email"]
      graph = Koala::Facebook::GraphAPI.new(auth["credentials"]["token"])
      user.profile_picture = graph.get_picture(auth["uid"])
    end
  end


  # - Public Page methods

  def generate_public_page_url
    self.public_page_url = self.full_name.parameterize.underscore
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def generate_token
    self.token = rand(36**8).to_s(36)
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

  def photos_for_friend(friend, page_number = 1)
    self.friend_photos.where(:user_id => friend.id).page(page_number).per(20).sort_by{|photo| photo.priority(self)}
    #sql_literal = Arel::SqlLiteral.new(PhotoPermission.select(:photo_id).where(:owner_id => friend.id, :friend_id => self.id).to_sql)
    #friend.photos.where(Photo.arel_table[:id].in(sql_literal))
  end


  # - Invite methods

  def invite_all
    job_id = PostInvite.create(:inviter_id => self.id)
    UserJob.create!(:job_id => job_id, :user_id => self.id, :job_type => "post_invite", :status => "queued")
  end

  def invite(user, invite_info)
    invite = self.invited?(user)
    unless invite
      invite = Invite.new(:inviter_id => self.id, :invited_id => user.id, :status => "invited")
      invite.invite = invite_info
      invite.save!
    else
      invite.invite = invite_info
      invite.send_friends_invite
    end
  end

  def invited?(user)
    invite = Invite.where(:inviter_id => self.id, :invited_id => user.id, :status => "invited").first
  end


  # - Vote methods

  def vote(photos)
    photos = photos[0..2]
    unless photos.empty?
      Vote.destroy_all(:voter_id => self.id)
      photos.each do |photo|
        permited = PhotoPermission.where(:photo_id => photo.id, :friend_id => self.id, :owner_id => photo.user.id).exists?
        Vote.create(:photo_id => photo.id, :voter_id => self.id) if permited
      end
    end
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

  def voters_with_votes(page_number = 1)
    voters.page(page_number).per(5).map do |voter|
      { voter => voter.votes_for(self) }
    end
  end

  def votes_for(friend)
    friend.votes.where(:voter_id => self.id).includes(:photo)
  end

  def voted_photos
    self.photos.where('total_votes > 0').order('total_votes DESC').includes(:votes)
  end


  # Top Photo methods

  ['one', 'two', 'three'].each do |number|
    define_method "top_photo_#{number}" do
      Photo.find(self.instance_eval("top_photo_#{number}_id")) rescue nil
      #Photo.find(send("self.top_photo_#{number}_id")) rescue nil
    end
    define_method "top_photo_#{number}=" do |photo|
      instance_eval("self.top_photo_#{number}_id = photo.id")
      #send("self.top_photo_#{number}_id=", photo.id)
    end
  end


  # Job methods
  def user_photos_job
    self.user_jobs.where(:job_type => "user_photos").first
  end

  def load_user_data
    job_id = UserPhotos.create(:user_id => self.id)
    Rails.logger.info "[Queued Job with id #{job_id}]"
    UserJob.create!(:job_id => job_id, :user_id => self.id, :job_type => "user_photos", :status => "queued")
  end

  private :load_user_data, :generate_public_page_url

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
#  public_page        :boolean         default(TRUE)
#  public_page_url    :string(255)
#  email              :string(255)
#  token              :string(255)
#

