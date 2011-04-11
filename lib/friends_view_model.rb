class FriendsViewModel
  attr_accessor :left_row, :right_row, :job_status, :count, :page

  def initialize(attrs)
    @job_status = attrs[:job_status]
    @left_row = attrs[:left_row]
    @right_row = attrs[:right_row]
    @count = attrs[:count]
    @page = attrs[:page]
  end
end
