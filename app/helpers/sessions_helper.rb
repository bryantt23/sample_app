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

  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    
# permanent causes Rails to set the expiration to 
# 20.years.from_now automatically

# signed cookie securely encrypts the cookie before 
# placing it on the browser
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
=begin
In case you're wondering why we don't just use the signed user id, 
  without the remember token, this would allow an attacker with 
  possession of the encrypted id to log in as the user 
  in perpetuity. In the present design, an attacker with 
  both cookies can log in as the user only until the user logs out.
=end

=begin 
older way before Listing 8.36
  # Returns the current logged-in user (if any).
  def current_user
    
    # stores the result of User.find_by in an instance variable, 
    # which hits the database the first time but returns 
    # the instance variable immediately on subsequent invocations
    
    @current_user ||= User.find_by(id: session[:user_id])
 # find_by only gets executed if @current_user hasnâ€™t yet been assigned  
#  https://www.railstutorial.org/book/log_in_log_out#aside-or_equals     
  end
=end


  # Returns the user corresponding to the remember token cookie.
  def current_user

=begin
not a comparison, but rather is an assignment
"If session of user id exists 
(while setting user id to session of user id)"
=end
    if (user_id = session[:user_id])

      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end



  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end
  
  # Logs out the current user.
#   delete user from the session
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  
  
end