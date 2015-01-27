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


  # Returns the current logged-in user (if any).
  def current_user
    
    # stores the result of User.find_by in an instance variable, 
    # which hits the database the first time but returns 
    # the instance variable immediately on subsequent invocations
    
    @current_user ||= User.find_by(id: session[:user_id])
 # find_by only gets executed if @current_user hasn’t yet been assigned  
#  https://www.railstutorial.org/book/log_in_log_out#aside-or_equals 
    
  end
end