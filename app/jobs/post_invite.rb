class PostInvite < Resque::JobWithStatus
  extend Resque::Plugins::HerokuAutoscaler
  @queue = :post_invite

  def perform
    inviter = User.find(options['inviter_id'])
    graph = Koala::Facebook::GraphAPI.new(inviter.facebook_token)
    graph.put_wall_post("Hi everyone. Vote for My Three Best Photos. http://m3b-staging.heroku.com/vote/" + inviter.id.to_s,
                        {:name => "m3b", :link => "http://m3b-staging.heroku.com/vote/" + inviter.id.to_s}, 
                        inviter.facebook_uid)
  end
end
