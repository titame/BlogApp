class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :bad_access
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  helper_method :authorized_user?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authorized_user?(resource)
    (resource.user == current_user) || (current_user.admin?)
  end

  protected

  def bad_access
    redirect_to root_url, notice: "Sorry!Page you are trying to access doesn't exists"
  end
end
