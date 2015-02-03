require 'spec_helper'

feature "user signs in" do
  scenario "with valid email and password" do
    alice = Fabricate(:user)
    signin(alice)
    page.should have_content alice.username
  end
end
