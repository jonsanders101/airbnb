feature "When I create a listing" do

  feature "Given that I've signed in" do
    before(:each) do
      sign_up
    end

    scenario "I can add that listing" do
      expect { post_listing }.to change(Space, :count).by(1)
      expect(current_path).to eq "/all_spaces"
    end
  end
end
