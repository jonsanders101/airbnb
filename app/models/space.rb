require 'data_mapper'
require 'dm-validations'

class Space
  include DataMapper::Resource
  property :id, Serial
  property :name, Text
  property :description, String
  property :price, Integer
  property :host_id, Integer
end
