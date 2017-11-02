require 'data_mapper'
require 'dm-validations'

class Booking

  include DataMapper::Resource

  property :id, Serial
  property :guest_id, Integer, required: true
  property :space_id, Integer
  property :confirmed, Boolean, default: false
  property :date, Date
end
