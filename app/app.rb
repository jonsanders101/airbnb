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

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect '/'
    else
      flash.now[:errors] = ['Woops! Email or password is incorrect.']
      erb :'sessions/new'
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
      flash.now[:errors] = user.errors.full_messages
      erb :'users/sign_up'
    end
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
    @space = Space.get(params['id'].to_i)
    erb :'spaces/space'
  end

  set :partial_template_engine, :erb
  enable :partial_underscores

  run! if app_file == $0
end
