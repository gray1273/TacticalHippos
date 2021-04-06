class UserTypesController < ApplicationController

def index
    @user_types = UserType.all
  end

  def show
    @user_type = UserType.find(params[:id])
  end

  def new
    @user_type = UserType.new
  end

  def create
    @user_type = UserType.new(user_type_params)
    if @user_type.save
      redirect_to @user_type
    else
      render :new
    end
  end

  def edit
    @user_type = UserType.find(params[:id])
  end

  def update
    @user_type = UserType.find(params[:id])

    if @user_type.update(user_type_params)
      redirect_to @user_type
    else
      render:edit
    end
  end

  def destroy
    @user_type = UserType.find(params[:id])
    @user_type.destroy

    redirect_to root_path
  end

  private
    def user_type_params
      params.require(:user_type).permit(:title_string)
    end

end
