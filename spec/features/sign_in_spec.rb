feature 'When I log in' do

  feature 'Given that I have signed-up' do

    let!(:user) do
      User.create(username: 'testusername', email: 'test@test.com', password: 'Test password', password_confirmation: 'Test password', phone_number: '1234567')
    end

    scenario 'I can log out' do
      visit '/'
      expect(page).to have_current_path '/'
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
      within(:css, "form#login-form") do
        click_button('Log In')
      end
      within(:css, "form#signout-form") do
        click_button('Log Out')
      end
      expect(page).to have_current_path "/"
      expect(page).to_not have_content "Hello, Test user"
    end

    scenario 'I can log in' do
      visit '/'
      expect(page).to have_current_path '/'
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
      within(:css, 'form#login-form') do
        click_button('Log In')
      end
      expect(page).to have_current_path '/'
      expect(page).to have_content 'Hello, testusername'
    end
  end
end
