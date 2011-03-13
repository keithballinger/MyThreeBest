module HelperMethods

  def create_photos_with_permissions(user, photo_count, *friends)
    photos = []
    photo_count.times do
      photo = Factory.create(:photo, :user_id => user.id)
      photos << photo
      friends.each do |friend|
        PhotoPermission.create(:owner_id => user.id, :friend_id => friend.id, :photo_id => photo.id)
      end
    end
    photos
  end

end
