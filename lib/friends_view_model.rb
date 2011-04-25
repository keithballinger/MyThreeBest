class FriendsViewModel
  attr_accessor :rows, :job_status, :count, :page

  def initialize(attrs)
    @job_status = attrs[:job_status]
    @rows = attrs[:rows]
    @count = attrs[:count]
    @page = attrs[:page]
  end
end
