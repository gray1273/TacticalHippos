class RecommendationsController < ApplicationController

  before_action 

  def index
    @recommendations = Recommendation.all
    render :index
  end

  def show
    @recommendation = Recommendation.find(params[:id])
    render :show
  end

  def new
    @recommendation = Recommendation.new
    
  end

  def create
    @recommendation = Recommendation.new(user_type_params)
    
    
    if @recommendation.save
      render :index
    else
      render :new
    end
  end

  def edit
    @recommendation = Recommendation.find(params[:id])
  end

  def update
    @recommendation = Recommendation.find(params[:id])

    if @recommendation.update(user_type_params)
      redirect_to @recommendation
    else
      render :edit
    end
  end

  def destroy
    @recommendation = Recommendation.find(params[:id])
    @recommendation.destroy

    redirect_to @recommendation
  end

  private
    def user_type_params
      params.require(:recommendation).permit(:user_id, :course_id, :section_id, :instructor_id, :description, :recommendation_type)
    end

end
