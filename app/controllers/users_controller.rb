class UsersController < ApplicationController

  before_action :find_user, only: [:show, :edit, :update]

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
      render new_user_path
    end
  end

  def show
    @message = params[:message] if params[:message]
    @message ||= false
  end

  def edit
  end

  def update
    if @user.update?
      redirect_to user_path(@user)
    else
      render edit_user_path
    end
  end

  def destroy
    find_user.delete
    redirect_to root_path
  end

  private

    def user_params
      params.require(:user).permit(
        :name,
        :password,
        :nausea,
        :happiness,
        :tickets,
        :height,
        :admin
      )
    end

    def find_user
      @user = User.find(params[:id])
    end

end
