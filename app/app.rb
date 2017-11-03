ENV['RACK_ENV'] ||= 'development'

require_relative 'data_mapper_setup'
require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/multi_route'
require 'twilio-ruby'
require 'sanitize'
require 'erb'
require 'rotp'
require 'pry'

include ERB::Util
require 'sinatra/partial'

require_relative 'server'
require_relative 'controllers/booking'
require_relative 'controllers/sessions'
require_relative 'controllers/spaces'
require_relative 'controllers/users'


include DataMapperSetup
data_mapper_setup

class MakersBnb < Sinatra::Base

  before do
    @twilio_number = ENV['TWILIO_NUMBER']
    @account_number = ENV['ACCOUNT_SID']
    @auth_token = ENV['AUTH_TOKEN']

    @client = Twilio::REST::Client.new @account_number, @auth_token

    if params[:error].nil?
      @error =false
    else
      @error = false
    end
  end

  get '/' do
    erb :homepage
  end

  post '/users' do
    user = User.create(username: params[:username],
                       email: params[:email],
                       phone_number: params[:phone_number],
                       password: params[:password],
                       password_confirmation: params[:password_confirmation])
    if user.save
      session[:user_id] = user.id
      redirect '/'
    else
      flash.now[:errors] = user.errors.full_messages
      erb :'users/sign_up'
    end
  end

  get '/sign-up' do
    erb :'users/sign_up'
  end

  set :partial_template_engine, :erb
  enable :partial_underscores

  run! if app_file == $0
end
