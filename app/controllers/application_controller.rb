class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def authenticate_admin_user!
    authorize! :access, :admin
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, alert: exception.message
  end
end
