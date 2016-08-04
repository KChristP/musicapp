class UsersController < ApplicationController
  def index
    render :index
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login(@user)
      redirect_to users_url
    else
      flash.now[:user_errors] = @user.errors.full_messages
      render :new
    end
  end

  def new#aka show me the webpage that lets me input info about new users
    render :new
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
