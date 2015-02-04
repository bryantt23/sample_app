class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  # checks that the current user actually has a micropost with the given id.
  before_action :correct_user,   only: :destroy

# put the form on the Home page itself (i.e., the root path /
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

 
  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"

    # microposts appear on both the Home page and on 
    # the user’s profile page, so by using request.referrer we 
    # arrange to redirect back to the page issuing the 
    # delete request in both cases
    redirect_to request.referrer || root_url
  end

 

  private
  
# strong parameters via micropost_params, which permits only the 
# micropost’s content attribute to be modified through the web.   
def micropost_params
      # params.require(:micropost).permit(:content)
      params.require(:micropost).permit(:content, :picture)
    end

     def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end    
    