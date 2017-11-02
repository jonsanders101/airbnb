feature 'Homepage Link' do
  scenario 'each page has a link to the homepage' do
    #as each page as the following css
    visit '/'

    within 'div#logo'
    expect(page).to have_link(href: '/')
  end
end