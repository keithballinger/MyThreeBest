#require File.expand_path(File.dirname(__FILE__) + '/fake_redis')

#module Resque
  #@@queues = {}
  #@@redis = Redis.new
  #def self.redis=(var)
    #@@redis = Redis.new
  #end
  #def self.redis
    #@@redis
  #end
  #def self.enqueue(klass,params)
    #@@queues[klass.queue] ||= []
    #@@queues[klass.queue] << params
  #end
  #def self.fakequeue
    #@@queues
  #end
#end

