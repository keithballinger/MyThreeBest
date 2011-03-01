class UserPhotos < Resque::JobWithStatus
  @queue = :user_photos

  def perform
    user = User.find(options['user_id'])
    user.user_photos_job.update_attributes(:status => "working")
    graph = Koala::Facebook::GraphAPI.new(user.facebook_token)
    photos = []
    partial_photos = graph.get_connections("me", "photos")
    old_photo_count = 0
    photo_count = nil
    until old_photo_count == photo_count
      old_photo_count = photos.size
      photos = photos + partial_photos
      photos.uniq!
      photo_count = photos.size
      partial_photos = partial_photos.next_page
    end
    photos.uniq!
    total = photos.count
    num = 1
    photos.each do |photo|
      at(num, total, "Looking at photo #{num} of #{total}")
      preview = photo["images"][1]["source"]
      url = photo["images"][0]["source"]
      title = photo["name"]
      Photo.create!(:title => title, :preview_url => preview, :url => url, :user_id => user.id)
      num += 1
    end
    user.user_photos_job.update_attributes(:status => "completed")
    completed
  end

end
