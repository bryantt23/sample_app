require 'test_helper'

# created with 
#  rails generate integration_test site_layout
class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    
    # verify that the Home page is rendered using the correct view
    assert_template 'static_pages/home'
    
    # test for the presence of a particular link–URL combination by 
    # specifying the tag name a and attribute href   
    
#     verifies that there are two such links 
#     (one each for the logo and navigation menu element)
    assert_select "a[href=?]", root_path, count: 2
    
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
  end
end