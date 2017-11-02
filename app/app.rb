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
    erb :homepage
  end

  run! if app_file == $0
end
