feature 'When I reject a request' do

  scenario 'I can reject a booking' do
    sign_up
    post_listing
    create_booking
    visit '/spaces/requests'
    expect(page).to have_content('test space')
    expect(page).to have_content('Test user')
    expect(page).to have_content(Date.today)
    click_button 'Reject'
    expect(page).to have_current_path('/booking/rejected')
    click_on 'return to view requests'
    expect(page).to have_current_path('/spaces/requests')
    expect(page).not_to have_content('test space')
  end

end
