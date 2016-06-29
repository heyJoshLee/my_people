require "spec_helper"

feature "User creates a group" do
  scenario "with valid inputs and while logged in" do
    skip
    visit_sign_in_path_and_sign_in
    visit new_group_path
  end

end