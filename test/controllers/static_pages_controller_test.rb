require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  
#   it's using this method to dry the title "Ruby on Rails Tutorial Sample App"
#   @ is an instance variable

  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end
  
  test "should get home" do
    get :home
    assert_response :success
    
    # assert_select method, which lets us test for the presence of a 
    # particular HTML tag (sometimes called a “selector” 
  
    # assert_select "title", "Home | Ruby on Rails Tutorial Sample App"
    # assert_select "title", "Home | #{@base_title}"
    assert_select "title", "#{@base_title}"
  end

  test "should get help" do
    get :help
    assert_response :success
    
    assert_select "title", "Help | #{@base_title}"
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  test "should get contact " do
    get :contact 
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end

end
