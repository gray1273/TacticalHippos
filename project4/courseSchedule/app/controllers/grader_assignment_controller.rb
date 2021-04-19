class GraderAssignmentController < ApplicationController

    #Should eventually let them specifically search the courses
    def index
        @Courses = Course.all
    end

    #Handle grader assignments from client
    def edit
        section = GraderSection.find_by course_id: params[:course], section_id: params[:section], grader_id: params[:id]
        if params[:accepted] then 
            section.status = :accepted
        else
            section.status = :rejected
        end
        section.save
    end
end
