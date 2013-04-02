class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def authenticate_admin_user!
    #binding.pry
    authorize! :access, :admin
    authenticate_user!
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
end
