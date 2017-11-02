class UsersController < ApplicationController
  #
  # before_action :required_logged_out

  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      ##redirect_to
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @bands = Band.all
    @user = User.find_by(id: params[:id])
    render :show
  end


  private
  def user_params
    params.require(:user).permit(:email_address, :password)
  end


end
