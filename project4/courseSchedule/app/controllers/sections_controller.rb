class SectionsController < ApplicationController

  def index
    @sections = Section.all
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      redirect_to @section
    else
      render :new
    end
  end

  def create_safely(course_id, 
                    section_number, 
                    class_number, 
                    instructor_first_name, 
                    instructor_last_name, 
                    type, 
                    term, 
                    instruction_mode, 
                    location, 
                    start_date_year, 
                    start_date_month, 
                    start_date_day, 
                    end_date_year, 
                    end_date_month, 
                    end_date_day, 
                    days_of_week, 
                    start_time_hour, 
                    start_time_minute, 
                    end_time_hour, 
                    end_time_minute)
    return Section.find_or_create_by(
      :course_id => course_id,
      :user => User.find_or_create_by(
        :user_type => UserType.find_or_create_by(
          :title => "Instructor"
        ),
        :first_name => instructor_first_name,
        :last_name => instructor_last_name,
        :email => ""
      ),
      :section_type => SectionType.find_or_create_by(
        :title => type
      ), 
      :term => Term.find_or_create_by(
        :season => Season.find_or_create_by(
          :title => term.split(" ")[0]
        ),
        :year => term.split(" ")[1].to_i
      ),
      :instruction_mode => InstructionMode.find_or_create_by(
        :mode => instruction_mode
      ),
      :location => Location.find_or_create_by(
        :location => location
      ),
      :section_number => section_number,
      :class_number => class_number,
      :days_of_week => days_of_week,
      :start_date => Date.new(start_date_year,start_date_month,start_date_day),
      :end_date => Date.new(end_date_year,end_date_month,end_date_day),
      :start_time => Time.new(2000,1,1,start_time_hour,start_time_minute,00,"+00:00"),
      :end_time => Time.new(2000,1,1,end_time_hour,end_time_minute,00,"+00:00")
    )
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])

    if @section.update(section_params)
      redirect_to @section
    else
      render:edit
    end
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy

    redirect_to root_path
  end

  private
    def section_params
      params.require(:section).permit(:section_number, :class_number, :days_of_week,:location,:start_date,:end_date,:start_time,:end_time)
    end

end
