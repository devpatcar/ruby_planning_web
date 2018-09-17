class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def authorize
    redirect_to '/login' unless logged_in?
  end
end
