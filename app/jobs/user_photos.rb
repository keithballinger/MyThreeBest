class UserPhotos < Resque::JobWithStatus
  @queue = :user_photos

  def perform
    user = User.find(options['user_id'])
    user.user_photos_job.update_attributes(:status => "working")
    graph = Koala::Facebook::GraphAPI.new(user.facebook_token)
    photos = []
    photos = photos + get_photos(graph, "me")
    profile_pics_album = graph.get_connections("me", "albums").select{|x| x["name"] == "Profile Pictures"}.first["id"] rescue nil
    photos = photos + get_photos(graph, profile_pics_album)
    photos.uniq!
    total = photos.count
    num = 1
    photos.each do |photo|
      at(num, total, "Looking at photo #{num} of #{total}")
      preview = photo["images"][1]["source"]
      url = photo["images"][0]["source"]
      title = photo["name"]
      p = Photo.create!(:title => title, :preview_url => preview, :url => url, :user_id => user.id, :facebook_id => photo["id"])
      tagged_user_ids = photo["tags"]["data"].map{|tag| tag["id"]} rescue []
      tagged_user_ids.each do |tagged_user_id|
        tagged_user = User.find_by_facebook_uid(tagged_user_id)
        PhotoTag.create!(:user_id => tagged_user.id, :photo_id => p.id) if tagged_user
      end
      num += 1
    end
    user.user_photos_job.update_attributes(:status => "completed")
    job_id = UserPhotosPerms.create(:user_id => user.id)
    UserJob.create!(:job_id => job_id, :user_id => user.id, :job_type => "user_photos_perms", :status => "queued")
    completed
  end

  def get_photos(graph, object)
    return [] if object.nil?
    photos = []
    partial_photos = graph.get_connections(object, "photos")
    return partial_photos if partial_photos.next_page.nil?
    old_photo_count = 0
    photo_count = nil
    until old_photo_count == photo_count
      old_photo_count = photos.size
      photos = photos + partial_photos
      photos.uniq!
      photo_count = photos.size
      partial_photos = partial_photos.next_page
    end
    return photos.uniq
  end
end
