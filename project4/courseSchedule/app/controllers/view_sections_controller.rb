class ViewSectionsController < ApplicationController
    def index
        puts user.user_type
        @user_type = user.user_type
    end
end
