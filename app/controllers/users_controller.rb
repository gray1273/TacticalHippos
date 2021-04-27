class UsersController < ApplicationController

  before_action :configure_permitted_parameters
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
    puts "running1"
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
    puts "running2"
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

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:first_name, :last_name, :user_type, :email)

    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :user_type, :email])
    devise_parameter_sanitizer.permit(:first_name, :last_name, :user_type, :email)
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :user_type, :email)
    end

  #before filters

  def set_user
    @user = User.find(params[:id])
  end

  end
