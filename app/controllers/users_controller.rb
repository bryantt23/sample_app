class UsersController < ApplicationController
  
  # Before filters use the before_action command to arrange for 
  # a particular method to be called before the given actions.
    
  # before_action :logged_in_user, only: [:index, :edit, :update]
      before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
      
      
  # By default, before filters apply to every action in a controller
#   so here we restrict the filter to act only on the :edit and :update actions

  # To redirect users trying to edit another user’s profile, we’ll add a 
  # second method called correct_user, together with a before filter to call it   
  before_action :correct_user,   only: [:edit, :update]
  
  # To enforce access control using a before filter, 
  # this time to restrict access to the destroy action to admins
  before_action :admin_user,     only: :destroy
  
  def index
    # @users = User.all
    
#     above now obsolete
    @users = User.paginate(page: params[:page])
  end
  
  def show
#     instance variable = find method on User model to retrieve from 
#     database, uses params to retrieve user id 
    @user = User.find(params[:id])
    
    # pass an explicit @microposts variable to will_paginate
    @microposts = @user.microposts.paginate(page: params[:page])

# 7.1.3 uses the byebug gem 
    # debugger
  end
  
  def new
    @user = User.new
  end
    
  def create
    @user = User.new(user_params)
    # @user = User.new(params[:user])    # Not the final implementation!
    if @user.save      
#       log in new users automatically as part of the signup process
      # log_in @user
      # Before, we redirected to the user’s profile page 
      # flash[:success] = "Welcome to the Sample App!"
# redirect to a different page, Rails automatically knows its to a url
      # redirect_to @user
      
      
     # now that we’re requiring account activation
 # we now redirect to the root URL
      @user.send_activation_email
      # UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url            
    else
      render 'new'
    end
  end
  
  # id of the user is available in the params[:id] variable
  def edit
    @user = User.find(params[:id])
  end
  
#   very similar to create if/else 
  def update
    @user = User.find(params[:id])
    
#     uses strong parameters
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
        
  def destroy
    # combine the find and destroy into one line
    User.find(params[:id]).destroy
    
    flash[:success] = "User deleted"
    redirect_to users_url
  end
    
    
    
  end

  # strong parameters 
  # admin is not in the list of permitted attributes. 
  # This is what prevents arbitrary users from granting 
  # themselves administrative access to our application.
  
  # Since user_params will only be used internally by the 
  # Users controller and need not be exposed to 
  # external users via the web, we’ll make it private 
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
  
    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        
        # puts the requested URL in the session variable under the key 
        # :forwarding_url, but only for a GET request
        store_location
#         sessions_helper method
        
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end   
    
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      # redirect_to(root_url) unless @user == current_user
       
       # refactoring - define a current_user? boolean method for use in the 
       # correct_user before filter, defined in the Sessions helpers
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
    
    
end
