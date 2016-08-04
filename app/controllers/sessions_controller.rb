class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params[:email], user_params[:pasword])
    if @user
      @user.reset_session_token!
      login(@user)
      redirect_to users_url
    else
      flash.now[:errors] = "Bad login credentials"
      render :new
    end
  end

  def destroy
    logout
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
