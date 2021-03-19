class SectionTypesController < ApplicationController

def index
    @section_types = SectionType.all
  end

  def show
    @section_type = SectionType.find(params[:id])
  end

  def new
    @section_type = SectionType.new
  end

  def create
    @section_type = SectionType.new(section_type_params)
    if @section_type.save
      redirect_to @section_type
    else
      render :new
    end
  end

  def edit
    @section_type = SectionType.find(params[:id])
  end

  def update
    @section_type = SectionType.find(params[:id])

    if @section_type.update(section_type_params)
      redirect_to @section_type
    else
      render:edit
    end
  end

  def destroy
    @section_type = SectionType.find(params[:id])
    @section_type.destroy

    redirect_to root_path
  end

  private
    def section_type_params
      params.require(:section_type).permit(:type)
    end

end
