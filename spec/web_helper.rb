def sign_up(username: 'Test user',
            email: 'test@test.com',
            password: 'Test password',
            password_confirmation: 'Test password')
  visit '/users/new'
  within(:css, 'form#signup-form') do
    fill_in :username, with: username
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_button 'Sign up'
  end
end

def log_in(email = 'test@test.com', password = 'Test password')
  visit '/'
    within(:css, 'div#access-ribbon') do
      fill_in('email', with: email)
      fill_in('password', with: password)
      click_button('Log in')
    end
end


def second_user_sign_up(username: 'Second user',
  email: 'second@test.com',
  password: 'Second password',
  password_confirmation: 'Second password')
  visit '/sign-up'
  fill_in :username, with: username
  fill_in :email, with: email
  fill_in :password, with: password
  fill_in :password_confirmation, with: password_confirmation
  click_button 'Sign up'
end

def post_listing(space = 'test space', description = 'test description', price = 1000)
  click_button('list-space')
  within('//form[@id="listing_form"]') do
    fill_in 'space', with: space
    fill_in 'description', with: description
    fill_in 'price', with: price
    click_button('complete-listing')
  end
end

def create_booking(space = 'test space', date = Date.today)
  visit '/'
  click_button 'Book a trip!'
  select space, from: 'spaces'
  fill_in('booking-date', with: date)
  click_button('Request Booking')
end
