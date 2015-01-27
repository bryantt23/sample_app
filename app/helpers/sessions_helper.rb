module SessionsHelper

=begin
This places a temporary cookie on the user's browser containing 
an encrypted version of the user's id, which allows us to 
retrieve the id on subsequent pages using 
session[:user_id]. In contrast to the persistent 
cookie created by the cookies method, the temporary cookie 
created by the session method expires 
immediately when the browser is closed.
=end

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end
end