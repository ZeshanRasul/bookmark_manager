require 'bcrypt'
require 'dm-validations'

class User
  include BCrypt
  include DataMapper::Resource

  property :id,       Serial
  property :name,     String
  property :email,    String
  property :password_digest, BCryptHash

  attr_accessor :password_confirmation
  attr_reader :password

  validates_confirmation_of :password, :confirm => :password_confirmation

  def password=(password)
    @password=password
    self.password_digest = BCrypt::Password.create(password)
  end


end
