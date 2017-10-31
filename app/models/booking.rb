require 'data_mapper'
require 'dm-validations'

class Booking

  include DataMapper::Resource
  
  property :id, Serial
  property :guest_id, Integer
  property :space_id, Integer
  property :confirmed, Boolean
  property :date, Date
end
