def sign_up(username: 'Test user',
            email: 'test@test.com',
            phone_number: '07496950988',
            password: 'Test password',
            password_confirmation: 'Test password')
  visit '/sign-up'
  within(:css, "form#signup-form") do
    fill_in :username, with: username
    fill_in :email, with: email
    fill_in :phone_number, with: phone_number
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_button 'Sign up'
  end
end

def sign_in(email = 'test@test.com', password = 'Test password')
  visit '/'
    within(:css, 'div#access-ribbon') do
      fill_in('email', with: email)
      fill_in('password', with: password)
      click_button('Sign in')
    end
end


def second_user_sign_up(username: 'Second user',
  email: 'second@test.com',
  phone_number: '07496950989',
  password: 'Second password',
  password_confirmation: 'Second password')
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
    fill_in "space", with: space
    fill_in "description", with: description
    fill_in "price", with: price
    click_button("complete-listing")
  end
end

def create_space
  Space.create(name: 'test space',
              description: 'test description',
              price: 500,
              host_id: 1)
end

def create_booking
  Booking.create(guest_id: 1,
                space_id: 1,
                date: Date.today)
end

def create_space_2
  Space.create(name: 'test space 2',
              description: 'test description 2',
              price: 500,
              host_id: 2)
end

def create_booking_2
  Booking.create(guest_id: 2,
                space_id: 2,
                date: Date.today)
end
