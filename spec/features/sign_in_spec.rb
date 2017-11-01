feature "When I sign-in" do

  feature "Given that I have signed-up" do

    let!(:user) do
      User.create(username: 'testusername', email: 'test@test.com', password: 'Test password', password_confirmation: 'Test password', phone_number: '1234567')
    end

    scenario "I can sign-out" do
      visit "/"
      expect(page).to have_current_path "/"
      click_button("Sign out")
      expect(page).to have_current_path "/"
      expect(page).to_not have_content "Hello, Test user"
    end

    scenario "I can sign-in" do
      visit "/"
      expect(page).to have_current_path "/"
      click_button("Sign in")
      expect(page).to have_current_path "/sessions/new"
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
      within(:css, "form#signin-form") do
        click_button('Sign in')
      end
      expect(page).to have_current_path "/"
      expect(page).to have_content "Hello, testusername"
    end
  end
end
