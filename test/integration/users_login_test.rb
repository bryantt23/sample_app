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

  test "login with valid information followed by logout" do
    get login_path
    post login_path, session: { email: @user.email, password: 'password' }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    
    # Simulate a user clicking logout in a second window.
    delete logout_path
    
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end


end
