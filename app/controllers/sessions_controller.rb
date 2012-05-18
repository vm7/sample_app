class SessionsController < ApplicationController
 
  def new
  @title="Sign in!"
  end
  
  def create
    user = User.autenticate( params[:session][:email],params[:session][:password])
    
    if user.nil?
      @title="Sign in failure"
      flash.now[:error]="Invalid e-mail/password combination."
      render 'new'
    else
      
    end
         
  end
  
  def destroy
  end
end
