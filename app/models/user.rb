require 'data_mapper'
require 'dm-postgres-adapter'
require 'dm-validations'

class User
  include DataMapper::Resource
  property :id, Serial
  property :username, String,
      :required => true,
      :unique => true,
    :messages => {
      :presence => "We need your username.",
      :is_unique => "We already have that username."
    }
  property :password, String
end
