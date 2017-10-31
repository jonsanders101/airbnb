require 'data_mapper'
require 'dm-validations'

class Space

  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :description, Text
  property :price, Integer
  property :host_id, Integer  

end
