require 'bcrypt'

class User
  include BCrypt
  include DataMapper::Resource

  property :id,       Serial
  property :name,     String
  property :email,    String
  property :password, String
end
