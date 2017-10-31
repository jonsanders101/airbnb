def sign_up
  visit '/sign-up'
  fill_in :username, with: "Test user"
  fill_in :password, with: "Test password"
  # fill_in :password_confirmation, with: "1234567"
  click_button "Sign up"
end
