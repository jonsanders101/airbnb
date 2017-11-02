ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'data_mapper_setup'
require 'sinatra/partial'
require 'sinatra/flash'

include DataMapperSetup
data_mapper_setup

class MakersBnb < Sinatra::Base

  register Sinatra::Partial
  use Rack::MethodOverride
  register Sinatra::Flash

  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    erb :homepage
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])

    if user
      session[:user_id] = user.id
      redirect '/'
    else
      flash[:errors] = ['Woops! Email or password is incorrect.']
      redirect '/'
    end
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  delete '/sessions' do
    session[:user_id] = nil
    redirect '/'
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

  get '/spaces/new' do
    if session[:user_id]
      erb :'spaces/new'
    else
      flash[:errors] = ['You must be signed-in to request a booking.']
      redirect '/'
    end
  end

  post "/spaces" do
    space = Space.create(name: params[:space],
                        host_id: session[:user_id],
                        description: params[:description],
                        price: params[:price])
    if space.save
      redirect "/spaces"
    else
      flash[:errors] = ['Space wasn\'t added. You must have missed something. Please try again.']
      redirect '/spaces/new'
    end
  end

  get "/spaces" do
    erb :'spaces/index'
  end

  post "/booking" do
    if session[:user_id]
      space = Space.first(name: params[:'spaces'])
      booking = Booking.create(guest_id: session[:user_id],
                                space_id: (Space.first(name: params[:'spaces'])).id,
                                date: params[:'booking-date'])
      space.bookings << booking
      space.save
      redirect "/booking/successful" if booking
    else
      flash[:errors] = ['You must be signed-in to do that.']
      redirect '/'
    end
  end

  get "/booking/successful" do
    erb :'booking/successful'
  end

  get '/spaces/requests' do
    if session[:user_id]
      @my_spaces = {}
      Space.all(:host_id => session[:user_id]).each { |space| @my_spaces[space.id] = space.name }
      @requests = Booking.all(:confirmed => :pending)
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
    else
      flash[:errors] = ['You must be signed-in to do that.']
      redirect '/'
    end

    erb :'booking/all'
  end

  post '/booking/confirm' do
      @confirmed_id = params[:approve]
      @rejected_id = params[:reject]
      erb :'booking/confirmed'
  end

  post '/spaces/requests' do
      @my_spaces = {}
      Space.all(:host_id => session[:user_id]).each { |space| @my_spaces[space.id] = space.name }
      @requests = Booking.all(:confirmed => :pending)
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
    @space = Space.get(params['id'].to_i)
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
