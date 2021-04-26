class ViewSectionsController < ApplicationController
    def index
        puts "User type" + user.user_type
        @user_type = user.user_type
    end
end
