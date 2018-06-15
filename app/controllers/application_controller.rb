# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "please_log_in"
    redirect_to login_path
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_path unless current_user? @user
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
