class MicropostsController < ApplicationController

  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy
  
  
  def create

    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'pages/home'
    end
  end

  def destroy
   @micropost.destroy
   redirect_to(:back) 
  end
  
  def update
   @microposts=Micropost.find(params[:id]) 
  
  end
  
  def increment
   #@microposts=Micropost.find(params[:id]) 
   #@microposts.increment!(:like_counter)
   redirect_to(:back) 
  end
  
  private
  
  def authorized_user
    @micropost=Micropost.find(params[:id])
    flash[:success] = "Post deleted!"
    redirect_to root_path unless current_user?(@micropost.user)
  end
  

end