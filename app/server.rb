class MakersBnb < Sinatra::Base

  register Sinatra::Partial
  register Sinatra::Flash
  use Rack::MethodOverride
  enable :sessions
  set :session_secret, 'super secret'
  set :partial_template_engine, :erb
  enable :partial_underscores

  before do
    @phone = Phone.new

    if params[:error].nil?
      @error =false
    else
      @error = false
    end
  end

  get '/' do
    erb :homepage
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end

    def spaces
      @spaces ||= Space.all
    end

    def confirmed_booking_dates(space_id)
      confirmed_bookings = Space.get(space_id).bookings.select{ |booking|  booking.confirmed == :confirmed}
      confirmed_booking_dates = confirmed_bookings.map{|booking| booking.date}
      formatted_dates = confirmed_booking_dates.map{|date| date.strftime("%m/%d/%Y")}
      return formatted_dates
    end
  end
end
