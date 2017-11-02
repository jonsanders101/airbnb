class MakersBnb < Sinatra::Base

  post '/booking' do
    if session[:user_id]
      space = Space.first(name: params[:'spaces'])
      booking = Booking.create(guest_id: session[:user_id],
                                space_id: (Space.first(name: params[:'spaces'])).id,
                                date: params[:'booking-date'])
      space.bookings << booking
      space.save
      redirect '/booking/successful' if booking
    else
      flash[:errors] = ['You must be signed-in to request a booking.']
      redirect '/'
    end
  end

  get '/booking/successful' do
    erb :'booking/successful'
  end

  post '/booking/confirm' do
      @confirmed_id = params[:approve]
      @rejected_id = params[:reject]
      erb :'booking/confirmed'
  end

end
