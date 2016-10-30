class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def check_admin_rights
  	redirect_to root_path, alert: 'Você não possui privilegios para acessar' unless current_employee.admin?
  end
end
