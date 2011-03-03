class PhotosPermissions < Resque::JobWithStatus
  @queue = :photos_permissions

  def perform
    user = User.find(options['user_id'])
    friends = user.registered_friends

    friends.each do |friend|
      token = friend.facebook_token
      graph = Koala::Facebook::GraphAPI.new(token)
      photos = get_photos(graph, user.facebook_uid)
      photos.each do |photo|
        photo = Photo.find_by_facebook_id(photo["id"])
        if photo
          PhotoPermission.create!(:photo_id => photo.id, :friend_id => friend.id,
                                  :owner_id => user.id)
       end
      end
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
