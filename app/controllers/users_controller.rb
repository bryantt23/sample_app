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
  
  
  
  
  
end
