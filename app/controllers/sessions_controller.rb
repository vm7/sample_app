class SessionsController < ApplicationController
 
  def new
  @title="Sign in!"
  end
  
  def create
    user = User.authenticate(params[:session][:email],params[:session][:password])
    if user.nil?
      @title="Sign in failure"
      flash.now[:error]="Invalid e-mail/password combination."
      render 'new'
    else
      sign_in user #ova metoda je definirana u session helperu
      redirect_back_or(user)
    end       
  end
  

  def destroy
     sign_out#ova metoda je definirana u session helperu
     redirect_to root_path
  end

  
end
