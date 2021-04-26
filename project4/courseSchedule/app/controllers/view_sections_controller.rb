class ViewSectionsController < ApplicationController
    def index
        puts "User type" + current_user.user_type
        @user_type = current_user.user_type
    end
end
