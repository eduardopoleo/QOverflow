def signin(a_user=nil)
  user = a_user || Fabricate(:user)
  visit signin_path 
  fill_in "username", with: user.username
  fill_in "password", with: user.password
  click_button "Log In"
end
