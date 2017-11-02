feature "When I approve a request" do

    scenario "I can view a booking request for my property" do
      sign_up
      create_space
      create_booking
      visit '/spaces/requests'
      expect(page).to have_current_path('/spaces/requests')
      within('form#my-bookings')do
        expect(page).to have_content('test space')
        expect(page).to have_content('Test user')
        expect(page).to have_content(Date.today)
      end
    end


    scenario "I can approve a booking" do
      sign_up
      create_space_2
      create_booking_2
      visit '/spaces/requests'
       within('form#my-bookings')do
         expect(page).to have_content('test space 2')
         expect(page).to have_content('Test user')
         expect(page).to have_content(Date.today)
         click_button 'Approve'
       end
       expect(page).to have_current_path('/booking/confirm')
       click_button 'return to view requests'
       expect(page).to have_current_path('/spaces/requests')
   end

end
