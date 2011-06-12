class UserPhotosPerms < Resque::JobWithStatus
  extend Resque::Plugins::HerokuAutoscaler
  @queue = :photos_permissions

  def perform
    user = User.find(options['user_id'])
    friends = user.registered_friends
    total = friends.count
    num = 1
    friends.each do |friend|
      at(num, total, "Looking at user #{num} of #{total}")
      set_permissions(user, friend)
      set_permissions(friend, user)
      num += 1
    end
  end

  def set_permissions(user, friend)
    token = friend.facebook_token
    graph = Koala::Facebook::GraphAPI.new(token)
    ppics = graph.get_connections(user.facebook_uid, "albums").select{|x| x["name"] == "Profile Pictures"}.first["id"] rescue nil
    photos = []
    photos = photos + get_photos(graph, user.facebook_uid)
    photos = photos + get_photos(graph, ppics)
    photos.uniq!
    photos.each do |photo|
      photo = Photo.find_by_facebook_id(photo["id"])
      PhotoPermission.create(:photo_id => photo.id, :friend_id => friend.id, :owner_id => user.id) if photo
    end
  end

  def get_photos(graph, object)
    return [] unless object
    photos = []
    partial_photos = graph.get_connections(object, "photos") || []
    return partial_photos if partial_photos.next_page.nil?
    old_photo_count = 0
    photo_count = nil
    until old_photo_count == photo_count || partial_photos == []
      old_photo_count = photos.size
      photos = photos + partial_photos
      photos.uniq!
      photo_count = photos.size
      partial_photos = partial_photos.next_page || []
    end
    photos
  end

end
