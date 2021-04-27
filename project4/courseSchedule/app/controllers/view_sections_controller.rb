class ViewSectionsController < ApplicationController
    def index
        if user_signed_in?
            @user_type = current_user.user_type.title.upcase
            puts "Displaying information for: " + @user_type

            case @user_type
            when "GRADER"
                @data = get_grader_sections
            when "INSTRUCTOR"
                @data = get_instructor_sections
            when "ADMINISTRATOR"
                @data = get_admin_data
            else
                puts "User Type Error"
            end
        end
    end

    private

    #Return sections that the grader has applied to and is grading
    def get_grader_sections
        grader_sections = []

        grader_sections << GraderSection.where(:grader_id => current_user.id, status => :accepted)
        grader_sections << GraderSection.where(:grader_id => current_user.id, status => :applied)

        return grader_sections
    end

    #Return sections that the instructor is teaching
    def get_instructor_sections
        instructor_sections = Section.where(:instructor_id => current_user.id)

        return instructor_sections
    end

    #Return all courses and users
    def get_admin_data
        admin_data = []

        admin_data << Course.all
        admin_data << User.all

        return admin_data
    end
end
