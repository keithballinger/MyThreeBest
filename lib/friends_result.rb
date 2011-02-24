class FriendsResult
  attr_accessor :job_status, :friends, :friends_page_count, :friends_total_count

  def initialize(attrs)
    @job_status = attrs[:job_status]
    @friends = attrs[:friends]
    @friends_total_count = attrs[:friends_total_count]
  end
end
