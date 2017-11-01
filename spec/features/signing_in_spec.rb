feature 'Signing in' do
  scenario 'Testing that a new user can be created' do
    User.new(username: "Test user",
              email: 'test@test.com',
              phone_number: '07496950988',
              password: "Test password",
              password_confirmation: "Test password")
  end

  scenario 'after you sign up you are redirected to homepage' do
    sign_up
    expect(current_path).to eq("/")
  end

  scenario 'users will be asked to confirm password' do
    expect { sign_up(password_confirmation: "wrong")}.not_to change(User, :count)
  end

  scenario 'users count should go up by 1 following successful sign-up' do
    expect { sign_up }.to change(User, :count).by(1)
  end

  scenario 'checks for a valid email' do
    expect { sign_up(email: "wrong") }.not_to change(User, :count)
  end

  scenario 'username should appear on homepage following successful sign-up' do
    sign_up
    expect(current_path).to eq("/")
    expect(page).to have_content("Welcome, Test user")
  end
end