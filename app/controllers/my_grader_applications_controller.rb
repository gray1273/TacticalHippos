class MyGraderApplicationsController < ApplicationController
    def index
        if user_signed_in? then
            puts current_user
            @Applications = GraderSection.where( :grader_id => current_user.id )
            render 'index'
        else
            redirect_to '/users/sign_in'
        end
    end
end
