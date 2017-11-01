require 'data_mapper'
require 'dm-postgres-adapter'
require 'dm-validations'
require 'bcrypt'

class User
  include DataMapper::Resource

  property  :id, Serial
  property  :username, String, :required => true, :unique => true,
            :messages => { :presence => 'We need your username.', :is_unique => 'We already have that username.' }
  property  :password_digest, Text
  property  :email, String, format: :email_address, :required => true, :unique => true
  property  :phone_number, String, :length => 30

  has n, :spaces, :through => Resource

  attr_accessor :password_confirmation
  attr_reader   :password

  validates_confirmation_of :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end
