class GraderAssignmentController < ApplicationController
    def index
        if user_signed_in?
            @data = Course.all
        end
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
