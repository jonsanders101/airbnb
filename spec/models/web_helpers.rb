def sign_up(username: 'Test user',
            password: 'Test password',
            password_confirmation: 'Test password')
  visit '/sign-up'
  fill_in :username, with: username
  fill_in :password, with: password
  fill_in :password_confirmation, with: password_confirmation
  click_button 'Sign up'
end
