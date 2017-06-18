class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    @user = find_user
  end

  def edit
    @user = find_user
  end

  def update
    @user = find_user
    if @user.update?
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    find_user.delete
    redirect_to :root
  end

  private

    def user_params
      params.require(:user).permit(:name, :password, :nausea, :happiness, :tickets, :height, :admin)
    end

    def find_user
      User.find(params[:id])
    end

end
