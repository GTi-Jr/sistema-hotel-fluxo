class Admin::BaseController < ApplicationController
  layout "dashboard"
  before_action :authenticate_employee!
end