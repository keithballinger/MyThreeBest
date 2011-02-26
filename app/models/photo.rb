class Photo < ActiveRecord::Base

  # - Associations
  belongs_to :user
  has_many :votes

  # - Validations

  validates_presence_of :url
  validates_presence_of :total_votes
end

# == Schema Information
#
# Table name: photos
#
#  id          :integer         not null, primary key
#  title       :text
#  url         :string(255)     not null
#  preview_url :string(255)
#  user_id     :integer         not null
#  total_votes :integer         default(0)
#  created_at  :datetime
#  updated_at  :datetime
#
