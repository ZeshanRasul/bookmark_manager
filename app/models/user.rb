require 'bcrypt'
require 'dm-validations'

class User
  include DataMapper::Resource
  attr_reader :password
  attr_accessor :password_confirmation

  property :id,                   Serial, required: true
  property :email,                String, format: :email_address, required: true
  property :password_digest,      Text, required: true

  validates_confirmation_of :password
  validates_presence_of :email
  validates_format_of :email, as: :email_address

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

end
