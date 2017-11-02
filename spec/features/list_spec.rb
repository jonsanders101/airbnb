feature 'When I create a listing' do

  feature 'Given that I have signed in' do
    before(:each) do
      sign_up
    end

    scenario 'I can add a listing' do
      expect { post_listing }.to change(Space, :count).by(1)
    end

    scenario 'Adding a listing displays its name, description and price' do
      post_listing
      within('ul#spaces_container') do
        expect(page).to have_content 'test space'
        expect(page).to have_content 'test description'
        expect(page).to have_content '1000'
      end
    end

    scenario 'I can add multiple listings' do
      post_listing
      visit '/'
      # sign_up
      post_listing
      expect(Space.count).to eq 2
    end
  end
end
