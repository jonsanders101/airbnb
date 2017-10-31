def sign_up(username: 'Test user',
            password: 'Test password',
            password_confirmation: 'Test password')
  visit '/sign-up'
  fill_in :username, with: username
  fill_in :password, with: password
  fill_in :password_confirmation, with: password_confirmation
  click_button 'Sign up'
end

def post_listing
  click_button("list-space")
  within("//form[@id='listing_form']") do
    fill_in "space", :with => 'test space'
    fill_in "description", :with => 'test description'
    fill_in "price", :with => 1000
    click_button("complete-listing")
  end
end
