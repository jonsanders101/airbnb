feature 'Making a booking' do
  before(:each) do
    sign_up
    post_listing
  end

  scenario 'I can see when a space has been booked' do
    booking_1 = Booking.create(guest_id: 1,
                  space_id: 1,
                  confirmed: :confirmed,
                  date: Date.today)
    booking_2 = Booking.create(guest_id: 2,
                  space_id: 1,
                  confirmed: :confirmed,
                  date: Date.today + 3)
    space = Space.first
    space.bookings << booking_1
    space.bookings << booking_2
    space.save
    visit '/spaces/' + space.id.to_s
    expect(page).to have_current_path '/spaces/' + space.id.to_s
    expect(page.status_code).to be(200)
    expected_message_1 = "reserved on #{Date.today.strftime('%d/%m/%Y')}"
    expected_message_2 = "reserved on #{(Date.today + 3).strftime('%d/%m/%Y')}"
    within('.reservations_list') do
      expect(page).to have_content expected_message_1
      expect(page).to have_content expected_message_2
    end
  end

  scenario 'unconfirmed reservations are not shown' do
    booking = Booking.create(guest_id: 1,
                  space_id: 1,
                  confirmed: :pending,
                  date: Date.today + 7)
    space = Space.first
    space.bookings << booking
    space.save
    visit '/spaces/' + space.id.to_s
    expected_message = "reserved on #{(Date.today + 7).strftime('%d/%m/%Y')}"
    expect(page).not_to have_content expected_message
  end

end
