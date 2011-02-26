class FriendViewModel
  attr_accessor :name, :profile_image_url, :has_voted
  
  def initialize(attrs)
    @name = attrs[:name]
    @profile_image_url = attrs[:profile_image_url]
    @has_voted = attrs[:has_voted]
  end
end