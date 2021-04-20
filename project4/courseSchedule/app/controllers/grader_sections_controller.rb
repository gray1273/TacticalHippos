class GraderSectionsController < ApplicationController

  def index
    @grader_sections = GraderSection.all
  end

  def show
    @grader_section = GraderSection.find(params[:id])
  end

  def new
    @grader_section = GraderSection.new
  end

  def create
    @grader_section = GraderSection.new(grader_section_params)
    if @grader_section.save
      redirect_to @grader_section
    else
      render :new
    end
  end

  def edit
    @grader_section = GraderSection.find(params[:id])
  end

  def update
    @grader_section = GraderSection.find(params[:id])

    if @grader_section.update(grader_section_params)
      redirect_to @grader_section
    else
      render :edit
    end
  end

  def destroy
    @grader_section = GraderSection.find(params[:id])
    @grader_section.destroy

    redirect_to root_path
  end

  private
    def grader_section_params
      params.require(:grader_section).permit(:user_id, :section_id)
    end

end
