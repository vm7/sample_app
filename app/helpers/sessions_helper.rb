#helper je po defaultu dostupan samo u wievu,ukljucen je u application kontroleru koji onda nasljedjuju svi kontroleri
module SessionsHelper
  #radi sign in usera
  #permanent cookies<---signed
  #poziva se u session controleru
  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  #poziva se vise puta session perssits
  def current_user
    #ako je user nill assignat ce mu usera sa remeber talkena,ako  je tru
    @current_user ||= user_from_remember_token
  end

  def signed_in?
    !current_user.nil?
  end

  def signed_out
    self.current_user=nil
  end

  #poziva se u session controleru
  #sign out usera

  def sign_out
    cookies.delete(:remember_token)
    current_user = nil
  end

  private

  #autenticira usera sa saltom i proslsjedjue
  def user_from_remember_token
    User.authenticate_with_salt(*remember_token)
  end

  def remember_token
    cookies.signed[:remember_token] || [nil, nil]
  end

end