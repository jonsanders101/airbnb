require 'data_mapper'
require_relative 'models/booking'
require_relative 'models/space'
require_relative 'models/user'

module DataMapperSetup
  def data_mapper_setup
    DataMapper.setup(:default, "postgres://localhost/makersbnb_#{ENV['RACK_ENV']}")
    DataMapper.finalize
    DataMapper.auto_upgrade!
  end
end
