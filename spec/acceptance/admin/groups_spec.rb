require_relative '../acceptance_helper'

feature "Groups" do
  scenario "root should load" do
    visit "/admin/groups"
    page.should have_content
  end
end
