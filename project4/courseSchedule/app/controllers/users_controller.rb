class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params.merge(user_id: current_user.id))
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      flash[:success] = "Failed to update the profile."
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name,:email)
    end

  #before filters

  def set_user
    @user = User.find(params[:id])
  end

  end
