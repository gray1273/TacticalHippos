class SearchController < ApplicationController
    def index
        #https://www.rubyguides.com/2019/10/scopes-in-ruby-on-rails/
        @Courses = Course.where nil
        params.each do |key, value|
            if Course.column_names.include? key then
                #Filter down the number of classes based on remaining keys
                @Courses.where(key.to_sym => value);
            end
        end
    end    
end
