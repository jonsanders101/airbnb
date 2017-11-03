ENV['RACK_ENV'] ||= 'development'

require_relative 'data_mapper_setup'
require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'
require 'sinatra/multi_route'
require 'twilio-ruby'
require 'sanitize'
require 'erb'
require 'rotp'
require 'pry'

require_relative 'server'
require_relative 'controllers/booking'
require_relative 'controllers/sessions'
require_relative 'controllers/spaces'
require_relative 'controllers/users'

include ERB::Util
include DataMapperSetup
data_mapper_setup
