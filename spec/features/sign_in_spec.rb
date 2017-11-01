feature "When I sign-in" do
  feature "Given that I have signed-up" do
    before(:each) do
      sign_up
    end
    scenario "I can sign-out" do
      expect(page).to have_current_path "/"
      click_button("sign-out")
      expect(page).to have_current_path "/"
      expect(page).to_not have_content "Welcome, Test user"
    end
    scenario "I can sign-in" do
      expect(page).to have_current_path "/"
      click_button("sign-in")
      expect(page).to have_current_path "/sessions/new"
      expect(page).to_not have_content "Welcome, Test user"
    end
  end
end
