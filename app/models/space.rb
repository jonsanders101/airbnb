require 'data_mapper'
require 'dm-validations'

class Space

  include DataMapper::Resource

  property :id, Serial
  property :name, String, required: true
  property :description, Text
  property :price, Integer, required: true
  property :host_id, Integer, required: true

  has n, :bookings, :through => Resource
end
