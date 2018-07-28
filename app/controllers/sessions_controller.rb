class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_username(params[:username])
    if @user && @user.authenticate(params[:password]) && @user.admin?
      session[:user_id] = @user.id
      redirect_to admin_dashboard_path
    elsif @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash[:notice] = "Incorrect login information. Please try again."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:cart] = nil
    redirect_to root_path
  end
end
