ENV['RACK_ENV'] ||= 'development'

require_relative 'data_mapper_setup'
require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'

require_relative 'server'
require_relative 'controllers/booking'
require_relative 'controllers/sessions'
require_relative 'controllers/spaces'


include DataMapperSetup
data_mapper_setup

class MakersBnb < Sinatra::Base

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
      flash[:errors] = user.errors.full_messages
      redirect '/'
    end
    # params[:password] == params[:password_confirmation] ? (redirect '/') : (redirect '/sign-up')
  end

  get '/sign-up' do
    erb :'users/sign_up'
  end

  run! if app_file == $0
end
