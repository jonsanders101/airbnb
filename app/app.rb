ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'data_mapper_setup'
require 'sinatra/partial'
require 'sinatra/flash'
require 'sinatra/multi_route'
require 'twilio-ruby'
require 'sanitize'
require 'erb'
require 'rotp'

include ERB::Util
include DataMapperSetup
data_mapper_setup

class MakersBnb < Sinatra::Base
  register Sinatra::Partial
  use Rack::MethodOverride
  register Sinatra::Flash

  enable :sessions
  set :session_secret, 'super secret'

  before do
    @twilio_number = "+15005550006" #ENV['twilio_number'] 
    @client = Twilio::REST::Client.new ENV['account_sid'], ENV['auth_token']

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
    # params[:password] == params[:password_confirmation] ? (redirect '/') : (redirect '/sign-up')
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

  get "/users/:id" do
    erb :'users/account'
  end

  get "/users/phone/new" do
    erb :'users/phone'
  end

  post '/users/phone/verify' do
    @phone_number = Sanitize.clean(params[:phone_number])
    if @phone_number.empty?
      redirect to("/users/phone/verify/?error=1")
    end

    begin
      if @error == false
        current_user.phone_number = @phone_number
        if current_user.phone_verified == true
          @phone_number = url_encode(@phone_number)
          redirect to("/users/phone?phone_number=#{@phone_number}&verified=1")
        end
        totp = ROTP::TOTP.new("drawtheowl")
        code = totp.now
        current_user.code = code
        current_user.save
        @client.api.account.messages.create(
          :from => @twilio_number,
          :to => @phone_number,
          :body => "Your verification code is #{code}")
      end
    erb :'users/phone_verify'
    # rescue Twilio::REST::RestError
    #   redirect to("/?error=2")
    end
  end

  get '/users/phone/verify' do

  end

  post '/users/phone/success' do
    # @phone_number = params[:phone_number]
    @code = params[:code]
    current_user.phone_number = @phone_number
    if current_user.phone_verified == true
      @verified = true
    elsif current_user.nil? || current_user.code != @code
      @phone_number = url_encode(@phone_number)
      redirect to("/users/phone?phone_number=#{@phone_number}&error=1")
    else
      current_user.phone_verified = true
      current_user.save
    end
    erb :'users/phone_success'
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
