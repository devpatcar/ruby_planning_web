module SessionsHelper
  # Logs in the given user.
  def log_in(user_token, user_email)
    session[:user_token] = user_token
    session[:user_email] = user_email
  end

  def current_user
    session[:user_email]
  end

  def current_token
    session[:user_token]
  end

  # Returns the current logged-in user (if any).
  def logged_in?
    # TODO: secure the check on token
    if session[:user_token].present?
      true
    else
      false
    end
  end

  # Logs out the current user.
  def log_out
    session[:user_token] = nil
  end
end
