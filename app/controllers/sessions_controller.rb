# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    if @user && @user.authenticate(params[:session][:password])
      if user.activated?
        login_active
      else
        login_not_active
      end
    else
      flash.now[:danger] = t "msg_invalid"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def login_active
    log_in user
    params[:session][:remember_me] == Settings.checkbox ? remember(user) : forget(user)
    redirect_back_or @user
  end

  def login_not_active
    message = t "account_not_activated"
    flash[:warning] = message
    redirect_to root_path
  end
end
