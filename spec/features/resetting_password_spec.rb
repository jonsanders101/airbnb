feature 'Resetting password' do
  scenario 'When I forget my password, I can click a link to reset it' do
    visit '/'
    click_link 'forgot-password'
    expect(page).to have_content('Please enter your email address.')
  end
end
