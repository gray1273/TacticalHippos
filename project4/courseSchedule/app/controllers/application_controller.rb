class ApplicationController < ActionController::Base
    def temp 
        render "layouts/application"
    end
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:first_name, :last_name, :type, :email)
    devise_parameter_sanitizer.permit(:first_name, :last_name, :type, :email)
  end    
end
