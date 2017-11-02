class SessionsController < ApplicationController

  # before_action :require_logged_in, only: [:destroy]
  # before_action :require_logged_in, only: [:new, :create]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:email_address],
      params[:user][:password]
    )

    if user.nil?
      flash.now[:errors] = ["Invalid email address or password"]
      render :new
    else
      login!(user)
      redirect_to user_url(user.id)
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

end
