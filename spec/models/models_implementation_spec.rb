require_relative '../../app/models/user'
require_relative '../../app/models/space'
require_relative '../../app/models/booking'
require 'date'

feature 'User' do
  scenario 'Testing that a new user can be created' do
    user = User.new(username: "Test user")
    expect(user.save).to be true
  end
end

feature 'Space' do 
  scenario 'Testing that a new space can be created' do
    white_house = Space.new(name: 'The White House',
              description: "It's big, and white",
              price: 99,
              host_id: 3)
    expect(white_house.save).to be true
  end
end

feature 'Booking' do
  scenario 'Testing that a new booking can be created' do
    booking = Booking.new(guest_id: 1,
                          space_id: 1,
                          confirmed: false,
                          date: Date.today)
    expect(booking.save).to be true
  end
end
