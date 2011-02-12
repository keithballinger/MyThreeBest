class Friend
  include Toy::Store
  store :redis, Redis.new

  attribute :name, String
  attribute :id, String

end
