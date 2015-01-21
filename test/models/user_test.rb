require 'test_helper'

class UserTest < ActiveSupport::TestCase

=begin

To write a test for a valid object, we'll create 
an initially valid User model object @user using 
the special setup method, which automatically 
gets run before each test. 
Because @user is an instance variable, 
it's automatically available in all the tests, 
and we can test its validity using the 
valid? method 

=end

  def setup
    @user = User.new(name: "Example User", email: "user@example.com")
  end

  test "should be valid" do
    assert @user.valid?
  end
end