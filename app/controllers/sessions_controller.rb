class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    
  # if statement is true only if a user with the given email both exists 
  # in the database and has the given password, exactly as required
  
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
    else
      # Create an error message.
      flash[:danger] = 'Invalid email/password combination' # Not quite right!

=begin   
The issue is that the contents of the flash persist for one request, 
but--unlike a redirect, which we used in Listing 7.24--
re-rendering a template with render doesn't count as a request. 
The result is that the flash message persists 
one request longer than we want. 
=end
      
      render 'new'
    end
  end

  def destroy
  end




end

