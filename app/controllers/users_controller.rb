class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create ]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy
  def index
    #sleep 2
    @title="all users"
    @users=User.paginate(:page => params[:page], :per_page => 5 )
  #@users=User.all#vraca array
  end

  def show
    @user = User.find(params[:id])
    @microposts=@user.microposts.paginate(:page => params[:page], :per_page =>5)
    @micropost=Micropost.all
    @title = @user.name
  end
      
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'

  end
      
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end

  def new
    @user = User.new
    @title = "Sign up!"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to theApp!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end

  def edit
    #naci ce usera u bazi prema id-u
    @user=User.find(params[:id])
    @title="Edit Users"

  end

  def update
    @user=User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to @user, :flash => { :success => "Profile Updated" }
    else

      @title="Edit Users"
      render 'edit'
    end

  end

  def destroy
    User.find(params[:id]).destroy
    #flash[:success]="User deleted"
    redirect_to users_path, :flash =>{ :success => "User deleted" }
  end

  private

  def authenticate
    #flash[:notice] = "Please sign in to acess this page."
    #redirect_to signin_path unless signed_in?
    deny_access unless (signed_in? || @user)
  end

  def correct_user
    @user=User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  #redirektaj na root path ako trenutni user ima atribut admin false
  def admin_user
    @user=User.find(params[:id])
    redirect_to(root_path) if !current_user.admin? && current_user?(@user)
  end

end

