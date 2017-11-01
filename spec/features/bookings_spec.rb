feature "Making a booking" do
  before(:each) do
    sign_up
    post_listing
  end

  scenario "I can see when a space has been booked" do
    booking_1 = Booking.create(guest_id: 1,
                  space_id: 1,
                  confirmed: true,
                  date: Date.today)
    booking_2 = Booking.create(guest_id: 2,
                  space_id: 1,
                  confirmed: true,
                  date: Date.today + 3)
    space = Space.first
    space.bookings << booking_1
    space.bookings << booking_2
    space.save
    visit '/spaces/1'
    expected_message_1 = "reserved on #{Date.today.strftime("%d/%m/%Y")}"
    expected_message_2 = "reserved on #{(Date.today + 3).strftime("%d/%m/%Y")}"
    within('.reservations_list') do
      expect(page).to have_content expected_message_1
      expect(page).to have_content expected_message_2
    end
  end

end