require 'test_helper'
class UsersIndexTest < ActionDispatch::IntegrationTest

# older test
  # def setup
    # @user = users(:michael)
  # end
  
  def setup
    @admin     = users(:michael)
    @non_admin = users(:archer)
  end

# checking for a div with the required pagination class and 
# verifying that the first page of users is present
  test "index including pagination" do
    log_in_as(@admin)
    # log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete',
                                                    method: :delete
      end
    end
    
    # verifies that a user is destroyed by checking that User.count 
    # changes by −1 when issuing a delete request to the 
    # corresponding user path
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end
  
  