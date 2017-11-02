class MakersBnb < Sinatra::Base

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
      flash[:errors] = ['You must be signed-in to view booking requests on your spaces.']
      redirect '/'
    end
  end

  get '/spaces/new' do
    if session[:user_id]
      erb :'spaces/new'
    else
      flash[:errors] = ['You must be signed-in to list a space.']
      redirect '/'
    end
  end

  post '/spaces' do
    space = Space.create(name: params[:space],
                        host_id: session[:user_id],
                        description: params[:description],
                        price: params[:price])
    if space.save
      redirect '/spaces'
    else
      flash[:errors] = ['Space wasn\'t added. You must have missed something. Please try again.']
      redirect '/spaces/new'
    end
  end

  get '/spaces' do
    erb :'spaces/index'
  end

  get "/spaces/:id" do
    @space = Space.get(params['id'].to_i)
    erb :'spaces/space'
  end

end
