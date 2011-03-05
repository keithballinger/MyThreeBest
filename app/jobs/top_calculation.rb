class TopCalculation < Resque::JobWithStatus
  @queue = :top_calculation

  def perform
    user = User.find(options['user_id'])
    top_photos = user.photos.where("total_votes > 0").order("total_votes DESC").limit(3)
    user.top_photo_one = top_photos[0]
    user.top_photo_two = top_photos[1]
    user.top_photo_three = top_photos[2]
    user.save!
  end
end
