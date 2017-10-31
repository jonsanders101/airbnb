def sign_up
  visit "/"
  # TODO: Add sign-up instructions here
end

def post_listing
  click_button("list-space")
  within("//form[@id='listing_form']") do
    fill_in "space", :with => 'test space'
    fill_in "description", :with => 'test description'
    fill_in "price", :with => 1000
    click_button("complete-listing")
  end
end
