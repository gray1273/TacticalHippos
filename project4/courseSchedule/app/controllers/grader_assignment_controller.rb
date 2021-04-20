class GraderAssignmentController < ApplicationController

    #Should eventually let them specifically search the courses
    def index
        puts user_signed_in?
        puts current_user
        puts current_user.user_type_id
        puts "printed"
        #if user_signed_in? then
            #TODO: Add a list of all applications and let admin accept/reject them
        #else
            #redirect_to "search"
        #end
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
