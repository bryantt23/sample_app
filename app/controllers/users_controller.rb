class UsersController < ApplicationController
  
  # Before filters use the before_action command to arrange for 
  # a particular method to be called before the given actions.
    
    before_action :logged_in_user, only: [:edit, :update]
    
  # By default, before filters apply to every action in a controller
#   so here we restrict the filter to act only on the :edit and :update actions
  
  def show
#     instance variable = find method on User model to retrieve from 
#     database, uses params to retrieve user id 
    @user = User.find(params[:id])

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
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      
# redirect to a different page, Rails automatically knows its to a url
      redirect_to @user
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
  end

  
  
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
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
