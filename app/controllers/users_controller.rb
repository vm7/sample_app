class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :correct_user, :only => [:edit, :update]



  def show
    @user = User.find(params[:id])
    @title = @user.name
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
  
  private 
  
  def authenticate
  #flash[:notice] = "Please sign in to acess this page."
  #redirect_to signin_path unless signed_in?
  deny_access unless signed_in?
  end
  
  def correct_user
  @user=User.find(params[:id])
  redirect_to(root_path) unless current_user?(@user)
  end

end

