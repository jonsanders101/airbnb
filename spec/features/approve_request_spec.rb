feature "When I approve a request" do

  feature "Given that I've signed in" do
    before(:each) do
      sign_up
      create_space
      create_booking
    end

    scenario "I can view a booking request for my property" do
      visit '/spaces/requests'
      within('form#my-bookings')do
        expect(page).to have_content('test space')
        expect(page).to have_content('Test user')
        expect(page).to have_content(Date.today)
      end
    end
  end
end
