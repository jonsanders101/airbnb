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
      guest = User.first(id: booking.guest_id)
      if guest.phone_number
        Phone.send_message(guest.phone_number,"Congratulations, your booking has been approved!")
      end
      redirect '/booking/confirmed'
  end

  get '/booking/confirmed' do
    erb :'booking/confirmed'
  end

  post '/booking/reject' do
    booking = Booking.get(params[:booking_id])
    booking.confirmed = :rejected
    booking.save
    guest = User.first(id: booking.guest_id)
    if guest.phone_number
      Phone.send_message(guest.phone_number,"I'm sorry, your booking request has been denied!")
    end
    redirect '/booking/rejected'
  end
  
  get '/booking/rejected' do
    erb :'booking/rejected'
  end

end
