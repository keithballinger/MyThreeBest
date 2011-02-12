class Friend
  include Toy::Store
  store :redis, Store

  attribute :name, String
  attribute :id, String

end
