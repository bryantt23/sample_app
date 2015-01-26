class UsersController < ApplicationController
  
  
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
      flash[:success] = "Welcome to the Sample App!"
      
# redirect to a different page, Rails automatically knows its to a url
      redirect_to @user
    else
      render 'new'
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
  
end
