class InstructionModesController < ApplicationController

def index
    @instruction_modes = InstructionMode.all
  end

  def show
    @instruction_mode = InstructionMode.find(params[:id])
  end

  def new
    @instruction_mode = InstructionMode.new
  end

  def create
    @instruction_mode = InstructionMode.new(instruction_mode_params)
    if @instruction_mode.save
      redirect_to @instruction_mode
    else
      render :new
    end
  end

  def edit
    @instruction_mode = InstructionMode.find(params[:id])
  end

  def update
    @instruction_mode = InstructionMode.find(params[:id])

    if @instruction_mode.update(instruction_mode_params)
      redirect_to @instruction_mode
    else
      render:edit
    end
  end

  def destroy
    @instruction_mode = InstructionMode.find(params[:id])
    @instruction_mode.destroy

    redirect_to root_path
  end

  private
    def instruction_mode_params
      params.require(:instruction_mode).permit(:mode)
    end

end
