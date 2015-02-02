class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

# put the form on the Home page itself (i.e., the root path /
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private
  
# strong parameters via micropost_params, which permits only the 
# micropost’s content attribute to be modified through the web.   
def micropost_params
      params.require(:micropost).permit(:content)
    end
end