feature 'Signing in' do

  scenario 'after you sign up you are redirected to homepage' do
    sign_up
    expect(current_path).to eq("/")
  end

  scenario 'users will be asked to confirm password' do
    expect { sign_up(password_confirmation: "wrong")}.not_to change(User, :count)
  end

  scenario 'checks that a username is entered' do
    expect { sign_up(username: nil) }.to_not change(User, :count)
    expect(page).to have_content("Username must not be blank")
  end

  scenario 'checks that a unique username is entered' do
    sign_up
    expect { second_user_sign_up(username: "Test user") }.not_to change(User, :count)
    expect(page).to have_content("Welcome, Test user We already have that username")
  end

  scenario 'users count should go up by 1 following successful sign-up' do
    expect { sign_up }.to change(User, :count).by(1)
  end

  scenario 'checks for a valid email' do
    expect { sign_up(email: "wrong") }.not_to change(User, :count)
  end

  scenario 'checks for a unique email address' do
    sign_up
    expect { second_user_sign_up(email: "test@test.com") }.not_to change(User, :count)
    expect(page).to have_content("Welcome, Test user Email is already taken")
  end

  scenario 'checks that an email was provided' do
    expect { sign_up(email: nil) }.not_to change(User, :count)
    expect(page).to have_content("Email must not be blank")
  end

  scenario 'checks that phone number is provided' do
    expect { sign_up(phone_number: nil) }.not_to change(User, :count)
    expect(page).to have_content("Phone number must not be blank")
  end

  scenario 'username should appear on homepage following successful sign-up' do
    sign_up
    expect(current_path).to eq("/")
    expect(page).to have_content("Welcome, Test user")
  end
end
