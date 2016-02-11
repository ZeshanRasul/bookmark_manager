require 'bcrypt'
require 'dm-validations'

class User
  include BCrypt
  include DataMapper::Resource

  property :id,       Serial, required: true
  property :name,     String, required: true
  property :email,    String, required: true
  property :password_digest, BCryptHash

  attr_accessor :password_confirmation
  attr_reader :password

  validates_confirmation_of :password, :confirm => :password_confirmation

  validates_format_of :email, :as => :email_address


  def password=(password)
    @password=password
    self.password_digest = BCrypt::Password.create(password)
  end


end
