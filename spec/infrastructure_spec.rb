feature 'index' do
  scenario 'webpage loads' do
    visit("/")
    expect(page.status_code).to eq 200
    expect(page).to have_content "Test"
  end
end
