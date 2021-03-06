require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name:  "",
                                    email: "foo@invalid",
                                    password:              "foo",
                                    password_confirmation: "bar" }
    assert_template 'users/edit'
  end


#  test tries to visit the edit page, then logs in, and then 
# checks that the user is redirected to the edit page instead of 
# the default profile page

# removes the test for rendering the edit template
  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    name  = "Foo Bar"
    email = "foo@bar.com"
    
    # password and confirmation are blank, which is convenient for 
    # users who don’t want to update their passwords every time 
    # they update their names or email addresses
 
    patch user_path(@user), user: { name:  name,
                                    email: email,
                                    password:              "",
                                    password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to @user
    
    # @user.reload to reload the user’s values from the database and 
    # confirm that they were successfully updated
    @user.reload
    assert_equal @user.name,  name
    assert_equal @user.email, email
  end
  
  
  
end  
