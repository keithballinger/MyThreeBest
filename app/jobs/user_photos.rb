class UserPhotos < Resque::JobWithStatus
  @queue = :user_photos

  def perform
    user = User.find(options['user_id'])
    user.user_photos_job.update_attributes(:status => "working")
    graph = Koala::Facebook::GraphAPI.new(user.facebook_token)
    photos = graph.get_connections("me", "photos")
    total = photos.count
    num = 0
    photos.each do |photo|
      at(num, total, "Looking at photo #{num} of #{total}")
      preview = photos["images"].select{|x| x["width"] == 180}.first["source"]
      url = photos["images"].first["source"]
      title = photos["name"]
      Photo.create(:title => title, :preview_url => preview, :url => url, :user_id => user.id)
      num += 1
    end
    user.user_photos_job.update_attributes(:status => "completed")
    completed
  end
end
