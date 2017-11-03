class MakersBnb < Sinatra::Base

  post '/booking' do
    if session[:user_id]
      space = Space.get(params[:space_id])
      booking = Booking.create(guest_id: session[:user_id],
                                space_id: params[:space_id],
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
      booking = Booking.get(params[:booking_id])
      booking.confirmed = :confirmed
      booking.save
      redirect '/booking/confirmed'
  end

  get '/booking/confirmed' do
    erb :'booking/confirmed'
  end

  post '/booking/reject' do
    booking = Booking.get(params[:booking_id])
    booking.confirmed = :rejected
    booking.save
    redirect '/booking/rejected'
  end

  get '/booking/rejected' do
    erb :'booking/rejected'
  end

end
