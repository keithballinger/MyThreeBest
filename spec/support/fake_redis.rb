#class Redis
  #@@fakeredis = {}
   ##redefining new causes existing redis not to be called on subsequent calls to Redis.new
  #def self.connect(options = {})
    #self
  #end

  #def self.new(options = {})
    #self
  #end

  #def self.set(key,value)
    #@@fakeredis[key] = value.to_s
  #end

  #def self.get(key)
    #@@fakeredis[key]
  #end

  #def self.del(key)
    #@@fakeredis.delete(key)
  #end

  #def self.getfakehash
    #@@fakeredis
  #end

  #def self.expire(key,ttl)
  #end

  #def self.reset
    #@@fakeredis = {}
  #end

  #def self.incr(key)
    #@@fakeredis[key] = "0" if @@fakeredis[key].nil?
    #retval = @@fakeredis[key].to_i + 1
    #@@fakeredis[key] = retval.to_s
  #end

  #def self.decr(key)
    #@@fakeredis[key] = "0" if @@fakeredis[key].nil?
    #retval = @@fakeredis[key].to_i - 1
    #@@fakeredis[key] = retval.to_s
  #end

  #def self.multi
    #yield
  #end

  #def self.keys(key)
    #retval = []
    #reg = Regexp.escape(key).gsub(/\\\*/,".*")

    #@@fakeredis.each do |k,v|
      #if k =~ Regexp.compile(reg)
        #retval << k
      #end
    #end
    #retval
  #end

  #class Namespace
    #def self.new(namespace, options = {})
      #@namespace = namespace
      #@redis = options[:redis]
      #@redis = Redis.new if @redis.nil?
      #self
    #end
    #def self.set(key,value)
      #key = "#{@namespace.to_s}:#{key}"
      #@redis.set(key,value)
    #end
    #def self.get(key)
      #key = "#{@namespace.to_s}:#{key}"
      #@redis.get(key)
    #end
    #def self.del(key)
      #key = "#{@namespace.to_s}:#{key}"
      #@redis.del(key)
    #end
    #def self.namespace=(namespace)
      #@namespace = namespace
    #end
    #def self.expire(key,ttl)
    #end

    #def self.incr(key)
      #key = "#{@namespace.to_s}:#{key}"
      #@redis.incr(key)
    #end

    #def self.decr(key)
      #key = "#{@namespace.to_s}:#{key}"
      #@redis.decr(key)
    #end

    #def self.keys(key)
      #key = "#{@namespace.to_s}:#{key}"
      #keys = @redis.keys(key)
      #retkeys = []
      #keys.each do |k|
        #retkeys << k.gsub(Regexp.compile("^#{@namespace.to_s}:"),"")
      #end
      #retkeys
    #end
    #def self.reset
      #@redis.reset
    #end

    #def self.multi
      #yield
    #end

  #end
#end

