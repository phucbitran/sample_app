# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  before_action :find_user, :valid_user, :check_expiration, only: %i(edit update)

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "pass_reset_msg"
      redirect_to root_path
    else
      flash.now[:danger] = t "nil_email_msg"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add :password, t("can't_be_empty")
      render :edit
    elsif @user.update_attributes(user_params)
      reset_success
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def find_user
    @user = User.find_by email: params[:email]
    return unless @user.nil?
    flash[:danger] = t "user_nil"
    redirect_to root_path
  end

  def valid_user
    return if @user.activated? && @user.authenticated?(:reset, params[:id])
    redirect_to root_path
  end

  def check_expiration
    return unless @user.password_reset_expired?
    flash[:danger] = t "Password_reset_has_expired"
    redirect_to new_password_reset_path
  end

  def reset_success
    log_in @user
    @user.update_attributes(reset_digest: nil)
    flash[:success] = t "password_has_been_reset"
    redirect_to @user
  end
end
