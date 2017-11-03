ENV['RACK_ENV'] ||= 'development'

require_relative 'data_mapper_setup'
require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'

require_relative 'server'
require_relative 'controllers/booking'
require_relative 'controllers/sessions'
require_relative 'controllers/spaces'
require_relative 'controllers/users'


include DataMapperSetup
data_mapper_setup

class MakersBnb < Sinatra::Base

  get '/' do
    @display_space_names = ["Cheap Stays", "Luxury Soaps", "Thrills 'n' Spills"]
    @space_names = Space.all.map { |space| space.name }
    @display_space_names.length.times{ |i|
      @display_space_names[i] = @space_names[i] unless @space_names[i] == nil
    }
    erb :homepage
  end

  run! if app_file == $0
end
