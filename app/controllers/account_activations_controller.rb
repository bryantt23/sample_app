class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    
    # !user.activated? prevents our code from activating users 
    # who have already been activated
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      
      # If the user is authenticated according to the booleans above, 
      # we need to activate the user and update the activated_at timestamp
      user.activate
      # user.update_attribute(:activated,    true)
      # user.update_attribute(:activated_at, Time.zone.now)
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end