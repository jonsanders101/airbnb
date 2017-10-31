require_relative '../../app/models/user'

feature 'User' do
  scenario 'Testing that a new user can be created' do
    User.new(username: "Test user", password: "Test password")
  end
end

feature 'Signing up for a user account' do
  scenario 'after you sign up you are redirected to homepage' do
    sign_up
    expect(current_path).to eq("/")
  end
end
