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
  end
end
