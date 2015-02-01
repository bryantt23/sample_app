require 'test_helper'


class UserMailerTest < ActionMailer::TestCase

  test "account_activation" do
    user = users(:michael)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "Account activation", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    
# assert_match method, can be used either with a string or a regular expression
# check that the name, activation token, and escaped email appear in the email’s body   assert_match user.name,               mail.body.encoded
    assert_match user.activation_token,   mail.body.encoded
    
    # escape the test user’s email   assert_match CGI::escape(user.email), mail.body.encoded
  end
end