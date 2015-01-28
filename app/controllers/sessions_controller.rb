class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    
  # if statement is true only if a user with the given email both exists 
  # in the database and has the given password, exactly as required
  
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      
<<<<<<< HEAD
<<<<<<< HEAD
=======
      # Handling the submission of the “remember me” checkbox   
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      
>>>>>>> parent of 9c879b4... 8.5d
=======
>>>>>>> parent of 648893e... 8.4.5d
      # remember a logged-in user
      remember user
      
#       Rails automatically converts this to: user_url(user)
      redirect_to user
      
    else
      # Create an error message.
      # flash[:danger] = 'Invalid email/password combination' # Not quite right!

=begin   
The issue is that the contents of the flash persist for one request, 
but--unlike a redirect, which we used in Listing 7.24--
re-rendering a template with render doesn't count as a request. 
The result is that the flash message persists 
one request longer than we want. 
=end
      
   # Unlike the contents of flash, the contents of flash.now disappear 
   # as soon as there is an additional request
      
      flash.now[:danger] = 'Invalid email/password combination'
      
      render 'new'
    end
  end

  def destroy
    # log_out

#   to pass test about a user clicking logout in a second window.
    log_out if logged_in?
    
    redirect_to root_url
  end




end

