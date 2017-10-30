ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'data_mapper_setup'

include DataMapperSetup
data_mapper_setup

class MakersBnb < Sinatra::Base

get "/" do
  "Test"
end

run! if app_file == $0

end
