class SessionsController < ApplicationController
  def new
    render "new"
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash[:danger] = "Invalid email/password combination"
      render "new"
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
