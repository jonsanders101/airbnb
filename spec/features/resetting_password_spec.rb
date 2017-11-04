feature 'Resetting password' do
  scenario 'When I forget my password, I can click a link to reset it' do
    visit '/'
    click_link 'forgot-password'
    expect(page).to have_current_path('/users/recover')
    expect(page).to have_content('Please enter your email address.')
  end

  feature 'Given that I have signed up' do
    before(:each) sign_up
  end

  scenario 'I am assigned a reset token' do
    visit '/'
    click_link 'forgot-password'
    within(:css, \//form[@id=])
    fill_in('email')
end
