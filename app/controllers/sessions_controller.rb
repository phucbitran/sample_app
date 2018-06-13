# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remember_me] == Settings.checkbox ? remember(@user) : forget(@user)
      redirect_to @user
    else
      flash.now[:danger] = t "msg_invalid"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
