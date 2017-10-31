def sign_up(username: 'Test user',
            email: 'test@test.com',
            phone_number: '07496950988',
            password: 'Test password',
            password_confirmation: 'Test password')
  visit '/sign-up'
  fill_in :username, with: username
  fill_in :email, with: email
  fill_in :phone_number, with: phone_number
  fill_in :password, with: password
  fill_in :password_confirmation, with: password_confirmation
  click_button 'Sign up'
end

def post_listing(space = 'test space', description = 'test description', price = 1000)
  click_button("list-space")
  within("//form[@id='listing_form']") do
    fill_in "space", :with => 'test space'
    fill_in "description", :with => 'test description'
    fill_in "price", :with => 1000
    click_button("complete-listing")
  end
end
