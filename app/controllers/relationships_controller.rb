class RelationshipsController < ApplicationController
  before_action :logged_in_user

# find the user associated with the followed_id in the corresponding form, 
# and then use the appropriate follow or unfollow method
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    # redirect_to user

#  to respond to Ajax    
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)

#  to respond to Ajax    
    # redirect_to user
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end