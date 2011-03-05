class TopCalculation < Resque::JobWithStatus
  @queue = :top_calculation

  def perform
    user = User.find(options['user_id'])

  end
end
