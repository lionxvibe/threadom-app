module SessionsHelper
  def current_user
    @current_user ||= User.where(id: session[:user_id], is_locked: false).first if session[:user_id]
  rescue ActiveRecord::RecordNotFound => e
    session.delete(:user_id)
  end

  def auth
    redirect_to root_url if current_user.nil?
  end

  def admin?
    redirect_to root_url unless current_user&.is_admin
  end
end
