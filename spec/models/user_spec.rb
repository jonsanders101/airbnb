require_relative '../../app/models/user'

feature 'User' do
  scenario 'Testing that a new user can be created' do
    User.new(username: "Test user")
  end
end
