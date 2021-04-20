class GraderApplicationController < ApplicationController
    def index
        if user_signed_in? then
            @TextForButton = "Apply"
            @PathForButton = "apply"
            @Courses = Course.all
            render 'index'
        else
            redirect_to '/users/sign_in'
        end
    end
    

    def edit
        puts 'editing!!!' 
        puts params[:section_id]
    end
end
