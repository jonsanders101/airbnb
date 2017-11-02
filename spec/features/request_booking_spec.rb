feature "When I request a booking" do

  feature "given that a space has been listed" do

    before(:each) do
      sign_up
      post_listing
    end

    scenario "my request is stored in the booking table" do
      visit('/')
      click_button("Book a trip")
      expect(current_path).to eq('/spaces')
      expect(page).to have_css("form#booking-request")
      within("form#booking-request") do
        select 'test space', from: 'spaces'
        fill_in("booking-date", with: "31/10/2017")
      end
      click_button('Request Booking')
      expect(Booking.count).to eq 1
      expect(page).to have_content('Booking successful!')
    end

  end
end
