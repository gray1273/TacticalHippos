class RecommendationsController < ApplicationController

def index
    @recommendation = Recommendations.all
  end

  def show
    @recommendation = Recommendations.find(params[:id])
  end

  def new
    @recommendation = Recommendations.new
  end

  def create
    @recommendation = Recommendations.new(user_type_params)
    if @recommendation.save
      redirect_to @recommendation
    else
      render :new
    end
  end

  def edit
    @recommendation = Recommendations.find(params[:id])
  end

  def update
    @recommendation = Recommendations.find(params[:id])

    if @recommendation.update(user_type_params)
      redirect_to @recommendation
    else
      render :edit
    end
  end

  def destroy
    @recommendation = Recommendations.find(params[:id])
    @recommendation.destroy

    redirect_to root_path
  end

  private
    def user_type_params
      params.require(:user_type).permit(:title_string)
    end

end
