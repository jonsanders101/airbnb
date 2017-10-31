ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'data_mapper_setup'
require 'sinatra/partial'

include DataMapperSetup
data_mapper_setup

class MakersBnb < Sinatra::Base
<<<<<<< HEAD
  register Sinatra::Partial

  get "/" do
    # TODO: remove next line
    "Test"
    erb :homepage, :layout => :layout
=======
  enable :sessions
  set :session_secret, 'super secret'

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/' do
    erb :homepage
>>>>>>> working-branch
  end

  post '/users' do
    user = User.create(username: params[:username],
                       password: params[:password],
                       password_confirmation: params[:password_confirmation])
    session[:user_id] = user.id
    redirect '/'
  end

  get '/sign-up' do
    erb :'users/sign_up'
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end

  post "/spaces" do
    space = Space.create(name: params[:space],
                        host_id: session[:user_id],
                        description: params[:description],
                        price: params[:price])
    redirect "/spaces"
  end

  get "/spaces" do
    erb :'spaces/index'
  end

  helpers do
    def spaces
      @spaces ||= Space.all
    end
  end

<<<<<<< HEAD
  set :partial_template_engine, :erb
  enable :partial_underscores

=======
>>>>>>> working-branch
  run! if app_file == $0
end
