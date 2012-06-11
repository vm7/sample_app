#helper je po defaultu dostupan samo u wievu,ukljucen je u application kontroleru koji onda nasljedjuju svi kontroleri
module SessionsHelper
  #radi sign in usera
  #permanent cookies<---signed
  #poziva se u session controleru
  #def sign_in(user)
  # cookies.permanent.signed[:remember_token] = [user.id, user.salt]
  #current_user = user
  #end
  def sign_in(user)
    #cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    session[:user_id] = user.id
    self.current_user = user
  end



              #vraca trenutno logiranog usera
#<---------------------------------------------------------------------------
  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  #@current_user ||= user_from_remember_token
  end
#<------------------------------------------------------------------------------



  #poziva se vise puta session perssits
  #def current_user
  #ako je user nill assignat ce mu usera sa remeber talkena,ako  je tru
  # @current_user ||= user_from_remember_token
  #end

  def signed_in?
    !current_user.nil?
  end
  


  def signed_out
    self.current_user=nil
  end

  #poziva se u session controleru
  #sign out usera
  #def sign_out
  #cookies.delete(:remember_token)
  #current_user = nil
  #end

  #poziva se u session controleru
  def sign_out
    #cookies.delete(:remember_token)
    session[:user_id] = nil
    self.current_user = nil
  end
  
  
  
  def current_user?(user)
  user == current_user
  end
  
  
  def deny_access
  store_location
  redirect_to signin_path, :notice =>"Please sign in to acess this page."
  end
  
  def store_location
  #session je cookie koji automatski istekne na kraju sessiona
  session[:return_to] = request.fullpath
  end
  
  def redirect_back_or(default)
  redirect_to(session[:return_to] || default)
  clear_return_to
  end
  
  def clear_return_to
  session[:return_to] = nil
  end
  
  private

  #autenticira usera sa saltom i proslsjedjue
  #def user_from_remember_token
   # User.authenticate_with_salt(*remember_token)
  #end

  #def remember_token
   # cookies.signed[:remember_token] || [nil, nil]
  #end

end
