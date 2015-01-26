class UsersController < ApplicationController
  
  
  def show
#     instance variable = find method on User model to retrieve from 
#     database, uses params to retrieve user id 
    @user = User.find(params[:id])
  end
  
  def new
  end
end
