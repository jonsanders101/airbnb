ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'data_mapper_setup'
require 'sinatra/partial'

include DataMapperSetup
data_mapper_setup

class MakersBnb < Sinatra::Base
  register Sinatra::Partial

  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    erb :homepage
  end

  post '/users' do
    user = User.create(username: params[:username],
                       email: params[:email],
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

  post "/booking" do
    space = Space.first(name: params[:'spaces'])
    booking = Booking.create(guest_id: session[:user_id],
                              space_id: (Space.first(name: params[:'spaces'])).id,
                              date: params[:'booking-date'])
    space.bookings << booking
    space.save
    redirect "/booking/successful" if booking
  end

  get "/booking/successful" do
    erb :'booking/successful'
  end

  get '/spaces/requests' do

    @my_spaces = {}
    Space.all(:host_id => session[:user_id]).each { |space| @my_spaces[space.id] = space.name }
    @requests = Booking.all(:confirmed => false)
    @my_requests = {}
    @my_guests = {}

    @requests.each do |request|
      if @my_spaces.has_key?(request.space_id)
        @my_requests[request['id']] = request
        # TODO: need to have booking populated with guest_id
        guest = User.get(:id => request['guest_id'])
        guest = User.first()
        @my_guests[guest.id] = guest['username'] unless @my_guests.has_key?(request['guest_id'])
      end
    end

    erb :'booking/all'
  end

  get "/spaces/:id" do
    @space = Space.get(params['id'])
    erb :'spaces/space'
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end

    def spaces
      @spaces ||= Space.all
    end
  end

  set :partial_template_engine, :erb
  enable :partial_underscores

  run! if app_file == $0
end
