class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def check_admin_rights
  	redirect_to root_path, alert: 'Você não possui privilegios para acessar' unless current_employee.admin?
  end

  ##Se for do bar: não pode acessar os lançamentos padrões
  def check_lanc_rights
  	redirect_to root_path, alert: 'Você não possui privilegios para acessar' if current_employee.sector_id == 2 || current_employee.sector_id == 3
  end

  ##So pode acessar o bar se tiver as perm
  def check_bar_rights
    unless current_employee.admin?
      redirect_to root_path, alert: 'Você não possui privilegios para acessar' unless current_employee.sector_id == 2 || current_employee.sector_id == 3
    end
  end
end
