require "spec_helper"

feature "User signs in" do
  scenario "with valid credentials" do
    visit_sign_in_path_and_sign_in
    expect(page).to have_content("Sign Out")
  end

end