module SessionsHelper

  def sign_in(user)
    session[:user_id] = user.id
    current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_session
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in."
    end
  end

  def sign_out
    current_user = nil
    session.delete(:user_id)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  private

    def user_from_session
      sess_id = session[:user_id]
      User.find_by_id(sess_id) unless sess_id.nil?
    end

    def clear_return_to
      session.delete(:return_to)
    end
end
