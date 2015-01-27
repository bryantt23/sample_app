require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
=begin
Visit the login path.
Post valid information to the sessions path.
Verify that the login link disappears.
Verify that a logout link appears
Verify that a profile link appears.
=end
  
  def setup
    @user = users(:michael)
  end
  
  
=begin
Visit the login path.
Verify that the new sessions form renders properly.
Post to the sessions path with an invalid params hash.
Verify that the new sessions form gets re-rendered and that a flash message appears.
Visit another page (such as the Home page).
Verify that the flash message doesn't appear on the new page.
=end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end


end
