class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :facebook_uid, :facebook_token, :first_name, :last_name
  validates_presence_of :facebook_uid
  validates_presence_of :facebook_token
  validates_uniqueness_of :facebook_uid
end
