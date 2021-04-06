class SearchController < ApplicationController
    def index
        #https://www.rubyguides.com/2019/10/scopes-in-ruby-on-rails/
        #@Courses = Course.where nil
        #params.each do |key, value|
            #puts key, " has ", value
            #if Course.column_names.include? key then
                #Filter down the number of classes based on remaining keys
                #@Courses.where(key.to_sym => value);
            #end
        #end
        if params[:class_name] then
            puts "Searching for it!!!", params[:class_name]
            @Courses = Course.where("title LIKE ?", "%" + params[:class_name] + "%")
        else
            @Courses = Course.where nil
        end
    end    
end
