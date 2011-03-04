class PhotosPermissions < Resque::JobWithStatus
  @queue = :photos_permissions

  def perform
    user = User.find(options['user_id'])
    friend = User.find(options['friend_id'])
    graph = Koala::Facebook::GraphAPI.new(user.facebook_token)
    photos = get_photos(graph, friend.facebook_uid)
    photos.each do |photo|
      photo = Photo.find_by_facebook_id(photo["id"])
      PhotoPermission.create!(:photo_id => photo.id, :friend_id => friend.id, :owner_id => user.id) if photo
    end
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
