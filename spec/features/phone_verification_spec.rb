feature 'Phone verification' do
  phone_number = 1234
  scenario 'User phone number is extracted and displayed on verification page' do
    sign_up
    click_button 'My Account'
    click_button 'Yes'
    fill_in "phone_number", with: phone_number
    click_button('Confirm')

    expect(page).to have_content(phone_number)
  end
end
